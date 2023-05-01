locals {
  env                   = "dev"
  app_name              = "project-special"
  technical_domain_name = "special-dev.mc.keycore.cloud"
  vpc_cidr              = "10.98.0.0/18"
  # vpc_private_subnets   = ["10.98.1.0/24", "10.98.2.0/24", "10.98.3.0/24"]
  vpc_private_subnets = ["10.98.1.0/24", "10.98.2.0/24"]
  # vpc_public_subnets    = ["10.98.11.0/24", "10.98.12.0/24", "10.98.13.0/24"]
  vpc_public_subnets = ["10.98.11.0/24", "10.98.12.0/24"]

  additional_domains = {
    "ps_test" = {
      "domain_name"               = "test.special-dev.mc.keycore.cloud"
      "subject_alternative_names" = ["test2.special-dev.mc.keycore.cloud"]
    },
  }

  internal_dns_records = {}
}
