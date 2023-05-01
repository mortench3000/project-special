output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "technical_domain_name" {
  value = local.technical_domain_name
}

output "technical_wildcard_certificate_arn" {
  value = aws_acm_certificate.technical_domain_wildcard.arn
}

output "additional_domains_certificate_arns" {
  value = values(aws_acm_certificate.listener_certificates)[*].arn
}

output "access_log_bucket_name" {
  value = module.access_log_bucket.s3_bucket_id
}

output "access_log_bucket_arn" {
  value = module.access_log_bucket.s3_bucket_arn
}
