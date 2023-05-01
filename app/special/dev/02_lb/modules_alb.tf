module "special_env_lb" {
  source                      = "../../../../modules/alb"
  name                        = "${local.app_name}-${local.env}-alb"
  vpc_id                      = data.terraform_remote_state.infrastructure.outputs.vpc_id
  private_subnets_cidr_blocks = data.terraform_remote_state.infrastructure.outputs.private_subnets_cidr_blocks

  public_subnets  = data.terraform_remote_state.infrastructure.outputs.public_subnets
  private_subnets = data.terraform_remote_state.infrastructure.outputs.private_subnets

  default_certificate_arn = data.terraform_remote_state.infrastructure.outputs.technical_wildcard_certificate_arn
  access_logs_bucket_name = data.terraform_remote_state.infrastructure.outputs.access_log_bucket_name
  access_logs_bucket_arn  = data.terraform_remote_state.infrastructure.outputs.access_log_bucket_arn

  env_domain_name = data.terraform_remote_state.infrastructure.outputs.technical_domain_name
  public_zone_id  = data.aws_route53_zone.selected.zone_id

  custom_dns_records = local.custom_dns_records
}
