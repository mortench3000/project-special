# Description

## Classic - ALB

### Modules for provisioning classic environment

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb_security_group"></a> [alb\_security\_group](#module\_alb\_security\_group) | terraform-aws-modules/security-group/aws | 4.16.2 |
| <a name="module_alb_security_group_internal"></a> [alb\_security\_group\_internal](#module\_alb\_security\_group\_internal) | terraform-aws-modules/security-group/aws | 4.16.2 |

## Resources

| Name | Type |
|------|------|
| [aws_lb.classic_env](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb.classic_env_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.http_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.api_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.api_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.rpt_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.rpt_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.web_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.web_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_route53_record.custom_records](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.internal_master-reports](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.internal_rpt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.wildcard_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_wafv2_web_acl.classic_env_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.classic_env_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |
| [aws_wafv2_web_acl_logging_configuration.classic_env_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_logging_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs_bucket_name"></a> [access\_logs\_bucket\_name](#input\_access\_logs\_bucket\_name) | (Optional) Provide name of access logs bucket to enable logging | `string` | `""` | no |
| <a name="input_custom_dns_records"></a> [custom\_dns\_records](#input\_custom\_dns\_records) | (Optional) Map of custom DNS records | `map(any)` | <pre>{<br>  "sample-alias": {<br>    "records": [],<br>    "type": "alias"<br>  },<br>  "sample-arecord": {<br>    "records": [<br>      "1.1.1.1"<br>    ],<br>    "type": "A"<br>  }<br>}</pre> | no |
| <a name="input_default_certificate_arn"></a> [default\_certificate\_arn](#input\_default\_certificate\_arn) | ARN of the certificate to use as default on the HTTPS listener | `string` | n/a | yes |
| <a name="input_env_domain_name"></a> [env\_domain\_name](#input\_env\_domain\_name) | Primary domain for the environment (should match the default cert) | `string` | n/a | yes |
| <a name="input_healthcheck_api_path"></a> [healthcheck\_api\_path](#input\_healthcheck\_api\_path) | n/a | `string` | `"/"` | no |
| <a name="input_healthcheck_rpt_path"></a> [healthcheck\_rpt\_path](#input\_healthcheck\_rpt\_path) | n/a | `string` | `"/"` | no |
| <a name="input_healthcheck_web_path"></a> [healthcheck\_web\_path](#input\_healthcheck\_web\_path) | n/a | `string` | `"/"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on ALB created | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of public subnets that the LB should listen in | `list(string)` | n/a | yes |
| <a name="input_private_subnets_cidr_blocks"></a> [private\_subnets\_cidr\_blocks](#input\_private\_subnets\_cidr\_blocks) | CIDR blocks for private subnets (used to limit egress traffic from LB) | `list(string)` | n/a | yes |
| <a name="input_private_zone_id"></a> [private\_zone\_id](#input\_private\_zone\_id) | Zone id of the private hosted zone (required to create the record) | `string` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | List of public subnets that the LB should listen in | `list(string)` | n/a | yes |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | Zone id of the public hosted zone (required to create the record) | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id that the LB should live in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_http_tg"></a> [api\_http\_tg](#output\_api\_http\_tg) | Target group for API instances on HTTP |
| <a name="output_api_https_tg"></a> [api\_https\_tg](#output\_api\_https\_tg) | Target group for API instances on HTTPS |
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the LB |
| <a name="output_arn_internal"></a> [arn\_internal](#output\_arn\_internal) | ARN of the internal LB |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | Amazon generated DNS name for the LB |
| <a name="output_dns_name_internal"></a> [dns\_name\_internal](#output\_dns\_name\_internal) | Amazon generated DNS name for the interal LB |
| <a name="output_http_listener"></a> [http\_listener](#output\_http\_listener) | The HTTP listener for the ALB |
| <a name="output_http_listener_internal"></a> [http\_listener\_internal](#output\_http\_listener\_internal) | The HTTP listener for the internal ALB |
| <a name="output_https_listener"></a> [https\_listener](#output\_https\_listener) | The HTTPS listener for the ALB |
| <a name="output_https_listener_internal"></a> [https\_listener\_internal](#output\_https\_listener\_internal) | The HTTPS listener for the internal ALB |
| <a name="output_rpt_http_tg"></a> [rpt\_http\_tg](#output\_rpt\_http\_tg) | Target group for RPT instances on HTTP |
| <a name="output_rpt_https_tg"></a> [rpt\_https\_tg](#output\_rpt\_https\_tg) | Target group for RPT instances on HTTPS |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | ARN of the LB security group |
| <a name="output_security_group_arn_internal"></a> [security\_group\_arn\_internal](#output\_security\_group\_arn\_internal) | ARN of the internal LB security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Id of the LB security group |
| <a name="output_security_group_id_internal"></a> [security\_group\_id\_internal](#output\_security\_group\_id\_internal) | Id of the internal LB security group |
| <a name="output_web_http_tg"></a> [web\_http\_tg](#output\_web\_http\_tg) | Target group for WEB instances on HTTP |
| <a name="output_web_https_tg"></a> [web\_https\_tg](#output\_web\_https\_tg) | Target group for WEB instances on HTTPS |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | Zone id of the DNS name hosting the records for the public LB, needed for alias records |
| <a name="output_zone_id_internal"></a> [zone\_id\_internal](#output\_zone\_id\_internal) | Zone id of the DNS name hosting the records for the internal LB, needed for alias records |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
