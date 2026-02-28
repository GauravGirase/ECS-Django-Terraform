# Step 1: Create ECS cluster
resource "aws_ecs_cluster" "ecs-cluster" {
    name = "${var.ecs_cluster_name}-${var.env}"
}

# Step 2: Create template file for container defination
data "template_file" "app" {
    template = file("templates/django_app.json.tpl")

    vars = {
        docker_image_url = var.docker_image_url
        region = var.region
    }
}

# Step 3: ECS task defination
resource "aws_ecs_task_definition" "app" {
  family = "django-app"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = var.cpu
  memory = var.memory
  execution_role_arn = var.execution_role_arn
  task_role_arn = var.task_role_arn
  container_definitions = data.template_file.app.rendered
}

# Step 4: ECS service
resource "aws_ecs_service" "app-service" {
    name = "${var.ecs_cluster_name}-service-${var.env}"
    cluster = aws_ecs_cluster.ecs-cluster.id
    task_definition = aws_ecs_task_definition.app.arn
    launch_type = "FARGET"
    desired_count = var.desired_count

    network_configuration {
      subnets = var.public_subnets
      security_groups = var.security_groups_ecs_farget
      assign_public_ip = true
    }
    
    load_balancer {
      target_group_arn = var.alb_target_group_arn
      container_name = "django-app"
      container_port = 8000
    }
}

# Step 5: Cloudwatch logs
resource "aws_cloudwatch_log_group" "django-log-group" {
    name = "/ecs/django-app"
    retention_in_days = var.log_retention_in_days
}

