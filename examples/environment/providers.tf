provider "aws" {
  profile                     = "appzen-admin"
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_get_ec2_platforms      = true
  skip_region_validation      = true
}

provider "aws" {
  alias                       = "legacy"
  profile                     = "appzen"
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_get_ec2_platforms      = true
  skip_region_validation      = true
}

# Switch to provider to remove assumeRole info
# Provider for each account: dev, qa, shared,
provider "aws" {
  alias   = "env"
  profile = "appzen-dev"
  region  = "${var.aws_region}"
}
