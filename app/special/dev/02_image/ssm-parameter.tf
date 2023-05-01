resource "aws_ssm_parameter" "special-image-ami" {
  name        = local.ami_id_ssm_parameter_name
  description = "Contains the latest custom built ami-id"
  type        = "String"
  data_type   = "aws:ec2:image"
  value       = data.aws_ami.latest-custom-ami.id
  overwrite   = true
}

resource "aws_cloudwatch_event_rule" "ssm-parameter-update-event-rule" {
  name        = "${var.name}-parameter-update-rule"
  description = "Capture updates to SSM Parameter holding latest custom ami-id"

  event_pattern = <<EOF
{
  "source": ["aws.ssm"],
  "detail-type": ["Parameter Store Change"],
  "detail": {
    "name": ["${aws_ssm_parameter.custom-image-ami.name}"],
    "operation": ["Create", "Update", "Delete", "LabelParameterVersion"]
  }
}
EOF
}

resource "aws_cloudwatch_log_group" "ssm-parameter-update-events-lg" {
  name              = "/aws/imagebuilder/${var.name}-parameter-update-events"
  retention_in_days = 30
}

resource "aws_cloudwatch_event_target" "ssm-parameter-update-events-target" {
  rule = aws_cloudwatch_event_rule.ssm-parameter-update-event-rule.name
  arn  = aws_cloudwatch_log_group.ssm-parameter-update-events-lg.arn
}

data "aws_iam_policy_document" "ssm-parameter-update-events-log-policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream"
    ]

    resources = [
      "${aws_cloudwatch_log_group.ssm-parameter-update-events-lg.arn}:*"
    ]

    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com"
      ]
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvents"
    ]

    resources = [
      "${aws_cloudwatch_log_group.ssm-parameter-update-events-lg.arn}:*:*"
    ]

    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com"
      ]
    }

    condition {
      test     = "ArnEquals"
      values   = [aws_cloudwatch_event_rule.ssm-parameter-update-event-rule.arn]
      variable = "aws:SourceArn"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "ssm-parameter-update-events-log-resource-policy" {
  policy_document = data.aws_iam_policy_document.ssm-parameter-update-events-log-policy.json
  policy_name     = "ssm-parameter-update-event-policy"
}
