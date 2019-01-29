//
// setup subdomain for mgmt environment
//

# TODO: set module to a version
module "domain" {
  source           = "git::https://github.com/devops-workflow/terraform-aws-route53-cluster-zone.git?ref=master"
  namespace        = ""
  stage            = ""
  name             = "${var.environment}"
  parent_zone_name = "${local.parent_zone}"
  zone_name        = "$${name}.$${parent_zone_name}"

  providers = {
    aws             = "aws.member"
    aws.parent_zone = "aws.member"
  }
}
