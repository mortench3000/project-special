locals {
  env      = "dev"
  app_name = "special"

  additional_domains_certificate_arns = data.terraform_remote_state.infrastructure.outputs.additional_domains_certificate_arns

  custom_dns_records = {
    "test-arecord" = {
      "type"    = "A"
      "records" = ["1.0.0.1"]
    },
    "test-alias" = {
      "type"    = "alias"
      "records" = []
    }
  }
}
