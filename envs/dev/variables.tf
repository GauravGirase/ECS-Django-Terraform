variable "region" {
    type = string
    description = "Aws region to create resources in."
    default = "ap-south-1"
}

variable "env" {
    type = string
    description = "Deployent environment"
    validation {
        condition = contains(["dev", "stage", "prod"], var.env)
        error_message = "Allowed values for env are: dev, stage, prod"
    }
}

variable "vpc_cidr_range" {
    type = string
    description = "CIDR range for VPC in which applications resources will be hosted"
}

variable "public_subnet_cidrs" {
    type = list(string)
    description = "CIDR range for public subnets"
}

variable "private_subent_cidrs" {
    type = list(string)
    description = "CIDR range for private subnets"
}

variable "health_check_path" {
  type = string
  description = "Health check path for the default target group"
  default = "/ping/"
}

variable "ecs_cluster_name" {
    type = string
    description = "ECS cluster name"
}

variable "docker_image_url" {
    type = string
    description = "Application docker image url"
}

variable "cpu" {
    type = string
    description = "CPU"
}

variable "memory" {
    type = string
    description = "Memory"
}


variable "desired_count" {
    type = number
    description = "Service containers count"
}

variable "log_retention_in_days" {
    type = number
    description = "Cloudwatch log retention days"
    default = 30
}

variable "autoscale_max" {
    type = number
    description = "ECS autoscaling max"
    default = 10
}

variable "autoscale_min" {
    type = number
    description = "ECS autoscaling max"
    default = 1
}

variable "ecs_service_name" {
    type = string
    description = "ECS service name"
}
