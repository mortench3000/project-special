resource "aws_route53_record" "custom_records" {
  for_each = var.custom_dns_records
  zone_id  = var.public_zone_id
  name     = "${each.key}.${var.env_domain_name}"
  type     = "A"

  # ttl     = 300
  # records = ["1.1.1.1"]
  ttl     = each.value.type == "A" ? 300 : null
  records = each.value.type == "A" ? each.value.records : null

  dynamic "alias" {
    # The for_each below determins if the "access_logs" block should exist or not.
    # If no bucket name is provided, then this block will not be generate, and if
    # a bucket name is provided, then this block will be generated only once
    # (i.e. by doing a for_each on a list containing only one item)
    for_each = each.value.type == "alias" ? [1] : []
    content {
      name                   = aws_lb.special_env.dns_name
      zone_id                = aws_lb.special_env.zone_id
      evaluate_target_health = true
    }
  }
}

resource "aws_route53_record" "wildcard_record" {
  zone_id = var.public_zone_id
  name    = "*.${var.env_domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.special_env.dns_name
    zone_id                = aws_lb.special_env.zone_id
    evaluate_target_health = true
  }
}
