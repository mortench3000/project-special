resource "aws_wafv2_web_acl" "special_env_waf" {
  name  = "${var.name}-waf-acl"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "RateLimit"
    priority = 0

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = "15000" # avg 50 req/sec over a 5 minute sample
        aggregate_key_type = "IP"
      }

    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.name}-waf-ratelimit-metric"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.name}-waf-metric"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_web_acl_logging_configuration" "special_env_waf_logging" {
  count                   = var.access_logs_bucket_name == "" ? 0 : 1
# log_destination_configs = ["arn:aws:s3:::${var.access_logs_bucket_name}"]
  log_destination_configs = [var.access_logs_bucket_arn]
  resource_arn            = aws_wafv2_web_acl.special_env_waf.arn
}

resource "aws_wafv2_web_acl_association" "special_env_waf_lb" {
  resource_arn = aws_lb.special_env.arn
  web_acl_arn  = aws_wafv2_web_acl.special_env_waf.arn
}
