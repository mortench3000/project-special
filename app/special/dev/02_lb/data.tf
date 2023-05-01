data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config = {
    key     = "project-special-dev/01-infra/terraform.tfstate"
    bucket  = "project-special-01-tf-state-eu-west-1"
    region  = "eu-west-1"
    profile = "keycore-mc-admin"
  }
}

data "aws_route53_zone" "selected" {
  name = "mc.keycore.cloud"
}
