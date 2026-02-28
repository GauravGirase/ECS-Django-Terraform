variable "ecs_cluster_name" {
  type = string
}

variable "security_group" {
    type = string
}

variable "subnets" {
    type = list(string)
}

variable "vpc_id" {type = string}
variable "health_check_path" {type = string}