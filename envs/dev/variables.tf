variable "region" {
    type = string
    description = "Aws region to create resources in."
    default = "ap-south-1"
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


