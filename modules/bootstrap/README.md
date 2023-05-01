## Description

A Terraform module that solves a 🐓 and 🥚 problem in new AWS accounts (or for AWS accounts that have never used Terraform): how do you Terraform the remote state bucket? It takes the approach of keeping a local statefile in the repository that only manages these resources:

- S3 bucket for remote state file,
- S3 bucket for storing state bucket access logs,
- DynamoDB table for state locking and consistency checking stack on your behalf and managing things that way.

## Example Usage

```hcl
module "bootstrap" {
  source        = "../../modules/bootstrap"
  account_alias = "special-dev"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform_state_bucket"></a> [terraform\_state\_bucket](#module\_terraform\_state\_bucket) | trussworks/s3-private-bucket/aws | 4.2.1 |
| <a name="module_terraform_state_bucket_logs"></a> [terraform\_state\_bucket\_logs](#module\_terraform\_state\_bucket\_logs) | trussworks/logs/aws | 14.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.terraform_state_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_alias"></a> [account\_alias](#input\_account\_alias) | The desired AWS account alias. | `string` | n/a | yes |
| <a name="input_bucket_purpose"></a> [bucket\_purpose](#input\_bucket\_purpose) | Name to identify the bucket's purpose | `string` | `"tf-state"` | no |
| <a name="input_dynamodb_table_name"></a> [dynamodb\_table\_name](#input\_dynamodb\_table\_name) | Name of the DynamoDB Table for locking Terraform state. | `string` | `"terraform-state-lock"` | no |
| <a name="input_dynamodb_table_tags"></a> [dynamodb\_table\_tags](#input\_dynamodb\_table\_tags) | Tags of the DynamoDB Table for locking Terraform state. | `map(string)` | <pre>{<br>  "Automation": "Terraform",<br>  "Name": "terraform-state-lock"<br>}</pre> | no |
| <a name="input_log_name"></a> [log\_name](#input\_log\_name) | Log name (for backwards compatibility this can be modified to logs) | `string` | `"log"` | no |
| <a name="input_log_retention"></a> [log\_retention](#input\_log\_retention) | Log retention of access logs of state bucket. | `number` | `90` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region. | `string` | `"eu-west-1"` | no |
| <a name="input_state_bucket_tags"></a> [state\_bucket\_tags](#input\_state\_bucket\_tags) | Tags to associate with the bucket storing the Terraform state files | `map(string)` | <pre>{<br>  "Automation": "Terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table"></a> [dynamodb\_table](#output\_dynamodb\_table) | The name of the dynamo db table |
| <a name="output_logging_bucket"></a> [logging\_bucket](#output\_logging\_bucket) | The logging\_bucket name |
| <a name="output_state_bucket"></a> [state\_bucket](#output\_state\_bucket) | The state\_bucket name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
