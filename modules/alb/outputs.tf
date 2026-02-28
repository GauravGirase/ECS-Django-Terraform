output "alb_target_group_arn" {
  value = aws_alb.ecs-alb.arn
}

output "alb_hostname" {
  value = aws_alb.ecs-alb.dns_name
}