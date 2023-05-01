resource "aws_lb_listener_certificate" "https_certificates" {
  for_each        = toset(local.additional_domains_certificate_arns)
  listener_arn    = module.special_env_lb.https_listener.arn
  certificate_arn = each.key
}
