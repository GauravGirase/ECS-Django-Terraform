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