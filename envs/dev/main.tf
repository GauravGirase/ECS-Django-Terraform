# Provision VPC
module "vpc" {
  source = "../../modules/vpc"
  vpc_cidr_range = var.vpc_cidr_range
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subent_cidrs = var.private_subent_cidrs
}

# Provision security groups
module "sg" {
  source = "../../modules/sg"
  vpc_id = module.vpc.vpc_id
}

# Provision ALB
module "alb" {
  source = "../../modules/alb"
  health_check_path = var.vpc_cidr_range
  vpc_id = module.vpc.id
  ecs_cluster_name = var.ecs_cluster_name
  security_group = module.sg.alb_sg_id
  subnets = module.vpc.public_subnets
}

# Provision IAM role 
module "iam" {
  source = "../../modules/iam"
  env = var.env
}

# Provision ECS cluster
module "ecs" {
  source = "../../modules/ecs"
  env = var.env
  region = var.region
  ecs_cluster_name = var.ecs_cluster_name
  task_role_arn = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  docker_image_url = var.docker_image_url
  desired_count = var.desired_count
  cpu = var.cpu
  memory = var.memory
  log_retention_in_days = var.log_retention_in_days
  security_groups_ecs_farget = [module.sg.alb_sg_id]
  public_subnets = [module.vpc.public_subnets]
  alb_target_group_arn = module.alb.alb_target_group_arn
}

# Provision : App autoscaling
module "asg" {
  source = "../../modules/asg"
  env = var.env
  autoscale_max = var.autoscale_max
  autoscale_min = var.autoscale_min
  ecs_cluster_name = module.ecs.ecs_cluster_name
  ecs_service_name = module.ecs.ecs_service_name
}
