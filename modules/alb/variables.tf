variable "name" {
  type        = string
  description = "Name to be used on ALB created"
}

variable "vpc_id" {
  type        = string
  description = "VPC id that the LB should live in"
}

variable "private_subnets_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for private subnets (used to limit egress traffic from LB)"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnets that the LB should listen in"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of public subnets that the LB should listen in"
}

variable "default_certificate_arn" {
  type        = string
  description = "ARN of the certificate to use as default on the HTTPS listener"
}

variable "env_domain_name" {
  type        = string
  description = "Primary domain for the environment (should match the default cert)"
}

variable "public_zone_id" {
  type        = string
  description = "Zone id of the public hosted zone (required to create the record)"
}

variable "access_logs_bucket_name" {
  type        = string
  description = "(Optional) Provide name of access logs bucket to enable logging"
  default     = ""
}

variable "access_logs_bucket_arn" {
  type        = string
  description = "(Optional) Provide the arn of access logs bucket to enable logging"
  default     = ""
}

variable "custom_dns_records" {
  type        = map(any)
  description = "(Optional) Map of custom DNS records"
  default = {
    "sample-arecord" = {
      "type"    = "A"
      "records" = ["1.1.1.1"]
    },
    "sample-alias" = {
      "type"    = "alias"
      "records" = []
    }
  }
}
