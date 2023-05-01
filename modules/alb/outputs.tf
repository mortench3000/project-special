output "arn" {
  description = "ARN of the LB"
  value       = aws_lb.special_env.arn
}

output "dns_name" {
  description = "Amazon generated DNS name for the LB"
  value       = aws_lb.special_env.dns_name
}

output "dns_name_internal" {
  description = "Amazon generated DNS name for the interal LB"
  value       = aws_lb.special_env.dns_name
}

output "security_group_id" {
  description = "Id of the LB security group"
  value       = module.alb_security_group.security_group_id
}

output "security_group_arn" {
  description = "ARN of the LB security group"
  value       = module.alb_security_group.security_group_arn
}

output "zone_id" {
  description = "Zone id of the DNS name hosting the records for the public LB, needed for alias records"
  value       = aws_lb.special_env.zone_id
}

output "http_listener" {
  description = "The HTTP listener for the ALB"
  value       = aws_lb_listener.http
}

output "https_listener" {
  description = "The HTTPS listener for the ALB"
  value       = aws_lb_listener.https
}

output "web_http_tg" {
  description = "Target group for WEB instances on HTTP"
  value       = aws_lb_target_group.web_http
}

output "web_https_tg" {
  description = "Target group for WEB instances on HTTPS"
  value       = aws_lb_target_group.web_https
}
