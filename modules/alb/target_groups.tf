resource "aws_lb_target_group" "web_https" {
  name     = "${var.name}-web-https-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
  # health_check {
  #   interval            = 30
  #   path                = var.healthcheck_web_path
  #   protocol            = "HTTPS"
  #   timeout             = 10
  #   healthy_threshold   = 2
  #   unhealthy_threshold = 2
  # }
}

resource "aws_lb_target_group" "web_http" {
  name     = "${var.name}-web-http-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  # health_check {
  #   interval            = 30
  #   path                = var.healthcheck_web_path
  #   protocol            = "HTTP"
  #   timeout             = 10
  #   healthy_threshold   = 2
  #   unhealthy_threshold = 2
  # }
}
