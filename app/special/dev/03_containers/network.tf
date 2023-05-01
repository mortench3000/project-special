resource "aws_security_group" "lb" {
  name        = "${local.env}-${local.app_name}-lb-sg"
  description = "Controls access to the Application Load Balancer (ALB)"

  vpc_id = data.terraform_remote_state.infrastructure.outputs.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    # Populate with origin cidr
    cidr_blocks = []
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    # Populate with origin cidr
    cidr_blocks = []
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "ecs_tasks" {
  name        = "${local.env}-${local.app_name}-ecstasks-sg"
  description = "Allow inbound access from the ALB only"

  vpc_id = data.terraform_remote_state.infrastructure.outputs.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 0
    to_port         = 65535
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
