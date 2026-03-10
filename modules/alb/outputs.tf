output "alb_target_group_arn" {
  value = aws_alb.ecs-alb.arn
}

output "alb_hostname" {
  value = aws_alb.ecs-alb.dns_name
}

output "alb_listener" {
  value = aws_alb_listener.ecs-alb-http-listener.arn
}