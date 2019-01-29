terraform-aws-env-base: environment

The module should create na new environment base setup

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_name | Name of member account. Format: namespace-account. Part after - is used for DNS subdomain | string | n/a | yes |
| aws\_region | AWS region to manage resources in | string | `"us-east-1"` | no |
| environment | Environment (ex: `dev`, `qa`, `stage`, `prod`). (Second or top level namespace. Depending on namespacing options) | string | n/a | yes |
| organization | Organization namespace | string | n/a | yes |
| top\_level\_domain | Top level DNS domain. Account subdomain will be added to this | string | n/a | yes |
| vpc\_cidr | CIDR block for VPC | string | n/a | yes |
| vpc\_name | Name of VPC | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
