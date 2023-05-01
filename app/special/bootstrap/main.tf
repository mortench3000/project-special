terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.2"
    }
  }
}

provider "aws" {
  region                   = "eu-west-1"
  shared_credentials_files = ["~/.aws/credentials"]
  shared_config_files      = ["~/.aws/config"]
  profile                  = "keycore-mc-admin"
  default_tags {
    tags = {
      terraform   = "true"
      env         = "common"
      application = "terraform"
      tfrepo      = "project-special"
    }
  }
}

module "bootstrap" {
  source        = "../../../modules/bootstrap"
  account_alias = "project-special-01"
}
