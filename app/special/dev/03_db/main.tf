terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4"
    }
  }

  backend "s3" {
    key            = "project-special-dev/03-db/terraform.tfstate"
    bucket         = "project-special-01-tf-state-eu-west-1"
    dynamodb_table = "terraform-state-lock"
    region         = "eu-west-1"
    encrypt        = "true"
    profile        = "keycore-mc-admin"
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
      env         = local.env
      application = local.app_name
      tfrepo      = "project-special"
    }
  }
}
