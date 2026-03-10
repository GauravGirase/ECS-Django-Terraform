output "public_subnets" {
    description = "Public subnets"
    value = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
    description = "Private subnets"
    value = aws_subnet.private_subnets[*].id
}

output "vpc_id" {
    description = "vpc id , will be used by dependent modules"
    value = aws_vpc.django_ecs.id
}