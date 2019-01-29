config {
terraform_version = "0.11.11"
deep_check = true
ignore_module = {
"cloudposse/dynamic-subnets/aws" = true
"cloudposse/vpc/aws" = true
"git::https://github.com/appzen-oss/terraform-aws-dynamic-subnets.git?ref=master" = true
"git::https://github.com/devops-workflow/terraform-aws-route53-cluster-zone.git?ref=master" = true
"git::ssh://git@bitbucket.org/appzeneng/terrazen_library.git//Modules/private_subnet" = true
"git::ssh://git@bitbucket.org/appzeneng/terrazen_library.git//Modules/public_subnet" = true
}
}

