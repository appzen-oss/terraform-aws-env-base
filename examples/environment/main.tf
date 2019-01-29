# Could reduce to cidr 21, but leave for now for more IPs

module "env" {
  source           = "../../"
  account_name     = "${var.account_name}"
  aws_region       = "${var.aws_region}"
  environment      = "${var.environment}"
  organization     = "${var.organization}"
  top_level_domain = "${var.top_level_domain}"
  vpc_cidr         = "${var.vpc_cidr}"
  vpc_name         = "${var.vpc_name}"

  providers = {
    aws.member      = "aws.env"
    aws.root_domain = "aws.legacy"
  }
}
