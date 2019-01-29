# terraform-aws-env-base

[![CircleCI](https://circleci.com/gh/appzen-oss/terraform-aws-env-base.svg?style=svg)](https://circleci.com/gh/appzen-oss/terraform-aws-env-base)
[![Github release](https://img.shields.io/github/release/appzen-oss/terraform-aws-env-base.svg)](https://github.com/appzen-oss/terraform-aws-env-base/releases)

Terraform module to manage the base configuration for an environment in it's
own VPC.

[Terraform registry](https://registry.terraform.io/modules/appzen-oss/env-base/aws)

## Usage

### Basic Example

```hcl
module "" {
  source        = "appzen-oss/env-base/aws"
  version       = "0.0.1"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_name | Name of member account. Format: namespace-account. Part after - is used for DNS subdomain | string | n/a | yes |
| aws\_region | AWS region to manage resources in | string | n/a | yes |
| environment | Environment (ex: `dev`, `qa`, `stage`, `prod`). (Second or top level namespace. Depending on namespacing options) | string | n/a | yes |
| organization | Organization namespace | string | n/a | yes |
| top\_level\_domain | Top level DNS domain. Account subdomain will be added to this | string | n/a | yes |
| vpc\_cidr | CIDR block for VPC | string | n/a | yes |
| vpc\_name | Name of VPC | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM GRAPH HOOK -->

### Resource Graph of plan

![Terraform Graph](resource-plan-graph.png)
<!-- END OF PRE-COMMIT-TERRAFORM GRAPH HOOK -->
