
output "ALB" {
  value = aws_lb.lb.id
}

output "alb_dns_name" {
  value = aws_lb.lb.dns_name
}

output "target_group" {
  value = aws_lb_target_group.target.id
}
