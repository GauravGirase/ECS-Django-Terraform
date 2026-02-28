# Define comman tags for all the resource
locals {
  common_tags = {
    ManagedBy = "Terraform"
    MaintainedBy = "devops@example.com"
    BusinessUnit = "BU-ED255"
  }
}

# Step 1: Create a vpc
resource "aws_vpc" "django_ecs" {
    cidr_block = var.vpc_cidr_range
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = merge({
        Name = "django-ecs"
    }, local.common_tags)

}


# Step 2: public & private subnets
data "aws_availability_zones" "azs" {
    state = available
}

resource "aws_subnet" "public_subnets" {
    count =  length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.django_ecs.id
    availability_zone = data.aws_availability_zones.azs[count.index]
    cidr_block = var.public_subnet_cidrs[count.index]
    map_public_ip_on_launch = true

    tags = merge({
        Name = "public-subnet-${count.index}"
    })
}

resource "aws_subnet" "private_subnets" {
    count =  length(var.private_subent_cidrs)
    vpc_id = aws_vpc.django_ecs.id
    availability_zone = data.aws_availability_zones.azs[count.index]
    cidr_block = var.private_subent_cidrs[count.index]

    tags = merge({
        Name = "private-subnet-${count.index}"
    }, local.common_tags)
}

# Step 3: internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.django_ecs.id

    tags = merge({
        Name = "django-ecs-igw"
    }, local.common_tags)
}

# Step 4: route table (public)
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.django_ecs.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = merge({
        Name = "public-rt"
    }, local.common_tags)
}

# Step 5: route table association (public)
resource "aws_route_table_association" "public_ra" {
    count = length(var.public_subnet_cidrs)
    subnet_id = aws_subnet.public_subnets[count.index].id
    route_table_id = aws_route_table.public_rt.id
}

# Step 6: Elastic ip for nat-gateway
resource "aws_eip" "eip" {
    domain = "vpc"
    
    tags = local.common_tags
}

# Step 7: Nat gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public_subnets[0]

  tags = local.common_tags
}

# Step 8: Route table (private)
resource "aws_route_table" "private_rt" {
   vpc_id = aws_vpc.django_ecs.id

   route {
    cidr_block = "0.0.0.0/1"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
   }

   tags = local.common_tags
  
}

# Step 9: Route table association (private)
resource "aws_route_table_association" "private_rta" {
    count = length(var.private_subent_cidrs)
    subnet_id = aws_subnet.private_subnets[count.index].id
    route_table_id = aws_route_table.private_rt.id
  
}