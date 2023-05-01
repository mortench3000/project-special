module "vpc" {
  source = "../../../../modules/vpc"
  name   = "${local.app_name}-${local.env}_vpc"

  cidr = local.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = local.vpc_private_subnets
  public_subnets  = local.vpc_public_subnets

  enable_nat_gateway   = true
  enable_dns_hostnames = true
}
