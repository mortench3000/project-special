################################################################################
# PostgreSQL Serverless v2
################################################################################

data "aws_rds_engine_version" "postgresql" {
  engine  = "aurora-postgresql"
  version = "14.7"
}

module "aurora_postgresql_v2" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "8.0.2"

  name                   = "${local.env}-${local.app_name}-pg"
  engine                 = data.aws_rds_engine_version.postgresql.engine
  engine_mode            = "provisioned"
  engine_version         = data.aws_rds_engine_version.postgresql.version
  storage_encrypted      = true
  create_db_subnet_group = true
  subnets                = data.terraform_remote_state.infrastructure.outputs.private_subnets

  vpc_id = data.terraform_remote_state.infrastructure.outputs.vpc_id
  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = data.terraform_remote_state.infrastructure.outputs.private_subnets_cidr_blocks
    }
  }

  monitoring_interval = 0

  apply_immediately            = true
  skip_final_snapshot          = true
  performance_insights_enabled = false

  serverlessv2_scaling_configuration = {
    min_capacity = 0.5
    max_capacity = 8
  }

  instance_class = "db.serverless"
  instances = {
    one = {}
    two = {}
  }

  master_username             = "postgres"
  manage_master_user_password = true
}
