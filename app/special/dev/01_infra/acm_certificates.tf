resource "aws_acm_certificate" "technical_domain_wildcard" {
  domain_name               = "*.${local.technical_domain_name}"
  validation_method         = "DNS"
  subject_alternative_names = [local.technical_domain_name]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "listener_certificates" {
  for_each                  = local.additional_domains
  domain_name               = each.value.domain_name
  subject_alternative_names = each.value.subject_alternative_names
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
