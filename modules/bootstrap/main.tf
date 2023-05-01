#
# Terraform state bucket
#

locals {
  state_bucket   = "${var.account_alias}-${var.bucket_purpose}-${var.region}"
  logging_bucket = "${var.account_alias}-${var.bucket_purpose}-${var.log_name}-${var.region}"
}

module "terraform_state_bucket" {
  source  = "trussworks/s3-private-bucket/aws"
  version = ">= 4.3"

  bucket         = local.state_bucket
  logging_bucket = local.logging_bucket

  use_account_alias_prefix = false
  tags                     = var.state_bucket_tags

  depends_on = [module.terraform_state_bucket_logs]
}

#
# Terraform state bucket logging
#

module "terraform_state_bucket_logs" {
  source  = "trussworks/logs/aws"
  version = "14.2.1"

  s3_bucket_name          = local.logging_bucket
  default_allow           = false
  s3_log_bucket_retention = var.log_retention
}

#
# Terraform state locking
#

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = var.dynamodb_table_name
  hash_key       = "LockID"
  read_capacity  = 2
  write_capacity = 2

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.dynamodb_table_tags
}
