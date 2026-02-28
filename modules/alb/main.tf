locals {
  common_tags = {
    ManagedBy = "Terraform"
    MaintainedBy = "devops@example.com"
    BusinessUnit = "BU-ED255"
  }
}

# Step 1: Create ALB
resource "aws_alb" "ecs-alb" {
    name = "${var.ecs_cluster_name}-alb"
    load_balancer_type = "application"
    internal = false
    security_groups = [var.security_group]
    subnets = var.subnets

    tags = local.common_tags
}

# Step 2: Create target group
resource "aws_alb_target_group" "default-target-group" {
    vpc_id = var.vpc_id
    name = "${var.ecs_cluster_name}-tg"
    port = 80
    protocol = "HTTP"
    target_type = "ip"

    health_check {
      path = var.health_check_path
      port = "traffic-port"
      healthy_threshold = 5
      unhealthy_threshold = 2
      timeout = 2
      interval = 5
      matcher = "200"
    }

    tags = local.common_tags
}

# Step 3: Listener (redirect traffic from the load balancer to the target group)
resource "aws_alb_listener" "ecs-alb-http-listener" {
    load_balancer_arn = aws_alb.ecs-alb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_alb_target_group.default-target-group.arn

    }

    depends_on = [ aws_alb_target_group.default-target-group ]
    tags = local.common_tags
}
