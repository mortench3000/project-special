data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_elb_service_account" "current" {}

data "aws_caller_identity" "current" {}
