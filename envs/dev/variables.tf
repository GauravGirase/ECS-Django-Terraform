variable "region" {
    type = string
    description = "Aws region to create resources in."
    default = "ap-south-1"
}

variable "env" {
    type = string
    description = "Deployent environment"
    validation {
        condition = contains(var.env , ["dev", "stage", "prod"])
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

variable "execution_role_arn" {
    type = string
    description = "Execution role arn"
}

variable "task_role_arn" {
    type = string
    description = "Task role arn"
}

variable "desired_count" {
    type = number
    description = "Service containers count"
}

variable "log_retention_in_days" {
    type = int
    description = "Cloudwatch log retention days"
    default = 30
}

variable "autoscale_max" {
    type = int
    description = "ECS autoscaling max"
    default = 10
}

variable "autoscale_min" {
    type = int
    description = "ECS autoscaling max"
    default = 1
}

variable "ecs_service_name" {
    type = string
    description = "ECS service name"
}
