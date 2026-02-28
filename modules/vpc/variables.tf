variable "vpc_cidr_range" {
    type = string
}

variable "public_subnet_cidrs" {
    type = list(string)
}

variable "private_subent_cidrs" {
    type = list(string)
}

