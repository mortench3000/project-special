resource "aws_lb" "special_env" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.alb_security_group.security_group_id]
  subnets            = var.public_subnets

  enable_deletion_protection = false

  dynamic "access_logs" {
    # The for_each below determins if the "access_logs" block should exist or not.
    # If no bucket name is provided, then this block will not be generate, and if
    # a bucket name is provided, then this block will be generated only once
    # (i.e. by doing a for_each on a list containing only one item)
    for_each = var.access_logs_bucket_name == "" ? [] : [1]
    content {
      bucket  = var.access_logs_bucket_name
      prefix  = ""
      enabled = true
    }
  }
}

module "alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name   = "${var.name}-sg"
  vpc_id = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  egress_cidr_blocks  = var.private_subnets_cidr_blocks
  egress_rules        = ["http-80-tcp", "https-443-tcp"]
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.special_env.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.default_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_https.arn
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.special_env.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_http.arn
  }
}

resource "aws_route53_record" "alias_route53_record" {
  zone_id = aws_route53_zone.primary.zone_id # Replace with your zone ID
  name    = "example.com" # Replace with your name/domain/subdomain
  type    = "A"

  alias {
    name                   = aws_lb.MYALB.dns_name
    zone_id                = aws_lb.MYALB.zone_id
    evaluate_target_health = true
  }
}
