resource "aws_lb" "alb" {
  name               = "${local.env}-${local.app_name}-alb"
  subnets            = data.terraform_remote_state.infrastructure.outputs.public_subnets
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.lb.id]
}

resource "aws_lb_listener" "http_forward" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

resource "aws_lb_listener" "https_forward" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.terraform_remote_state.infrastructure.outputs.technical_wildcard_certificate_arn


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name        = "${local.env}-${local.app_name}-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.infrastructure.outputs.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "90"
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = "20"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

resource "aws_lb_target_group" "alb_pgadmin4_tg" {
  name        = "${local.env}-${local.app_name}-alb-pgadmin4-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.infrastructure.outputs.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "90"
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = "20"
    path                = "/login"
    unhealthy_threshold = "2"
  }
}

resource "aws_lb_listener_rule" "pgadmin4" {
  listener_arn = aws_lb_listener.https_forward.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_pgadmin4_tg.arn
  }

  condition {
    host_header {
      values = ["special-pgadmin4.special-dev.mc.keycore.cloud"]
    }
  }

  # condition {
  #   path_pattern {
  #     values = ["/pgadmin4/*"]
  #   }
  # }
}

resource "aws_route53_record" "alias_route53_record" {
  zone_id = local.hosted_zone_id
  name    = "special-nginx.special-dev.mc.keycore.cloud"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "pgadmin4" {
  zone_id = local.hosted_zone_id
  name    = "special-pgadmin4.special-dev.mc.keycore.cloud"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
