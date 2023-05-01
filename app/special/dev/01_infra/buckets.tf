module "access_log_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = ">= 3.6"

  bucket = "aws-waf-logs-${local.app_name}-${local.env}-${data.aws_region.current.name}"

  attach_policy = true
  policy        = data.aws_iam_policy_document.allow_elb_write_access.json

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  force_destroy = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule = [
    {
      id      = "all"
      enabled = true

      expiration = {
        days = 14
      }

      noncurrent_version_expiration = {
        days = 7
      }
    },
  ]
}

data "aws_iam_policy_document" "allow_elb_write_access" {
  statement {
    sid     = "AllowELBLogDeliverWrite"
    effect  = "Allow"
    actions = ["s3:PutObject"]

    principals {
      type = "AWS"
      # ELB account id for a given region can be found here: https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html
      identifiers = [
        data.aws_elb_service_account.current.arn,
      ]
    }

    resources = [
      "${module.access_log_bucket.s3_bucket_arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
    ]
  }

  statement {
    sid     = "AWSLogDeliveryWrite"
    effect  = "Allow"
    actions = ["s3:PutObject"]

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    resources = [
      "${module.access_log_bucket.s3_bucket_arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control"
      ]
    }
  }

  statement {
    sid     = "AWSLogDeliveryAclCheck"
    effect  = "Allow"
    actions = ["s3:GetBucketAcl"]

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    resources = [
      module.access_log_bucket.s3_bucket_arn
    ]
  }
}
