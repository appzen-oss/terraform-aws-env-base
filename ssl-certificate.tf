//
// SSL certificate
//
resource "aws_acm_certificate" "env_wildcard" {
  depends_on                = ["module.domain"]
  provider                  = "aws.member"
  domain_name               = "*.${var.environment}.${local.parent_zone}"
  subject_alternative_names = ["*.${local.parent_zone}", "*.${var.top_level_domain}"]
  validation_method         = "DNS"

  tags = {
    Environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  alt_domains = "${list(
    aws_acm_certificate.env_wildcard.domain_validation_options.0.domain_name,
    aws_acm_certificate.env_wildcard.domain_validation_options.1.domain_name,
    aws_acm_certificate.env_wildcard.domain_validation_options.2.domain_name
  )}"
  domain_env    = "${index(local.alt_domains, "*.${var.environment}.${local.parent_zone}")}"
  domain_parent = "${index(local.alt_domains, "*.${local.parent_zone}")}"
  domain_root   = "${index(local.alt_domains, "*.${var.top_level_domain}")}"
}

resource "aws_route53_record" "env_wildcard_validation" {
  provider = "aws.member"
  depends_on = ["aws_acm_certificate.env_wildcard"]
  name     = "${lookup(aws_acm_certificate.env_wildcard.domain_validation_options[local.domain_env], "resource_record_name")}"
  type     = "${lookup(aws_acm_certificate.env_wildcard.domain_validation_options[local.domain_env], "resource_record_type")}"
  records  = ["${lookup(aws_acm_certificate.env_wildcard.domain_validation_options[local.domain_env], "resource_record_value")}"]
  zone_id  = "${module.domain.zone_id}"
  ttl      = 60
}

resource "aws_route53_record" "parent_wildcard_validation" {
  provider = "aws.member"
  depends_on = ["aws_acm_certificate.env_wildcard"]
  allow_overwrite = true
  name     = "${lookup(aws_acm_certificate.env_wildcard.domain_validation_options[local.domain_parent], "resource_record_name")}"
  type     = "${lookup(aws_acm_certificate.env_wildcard.domain_validation_options[local.domain_parent], "resource_record_type")}"
  records  = ["${lookup(aws_acm_certificate.env_wildcard.domain_validation_options[local.domain_parent], "resource_record_value")}"]
  zone_id  = "${module.domain.parent_zone_id}"
  ttl      = 60
}

data "aws_route53_zone" "root_domain" {
  provider = "aws.root_domain"
  name     = "${var.top_level_domain}."
}

resource "aws_route53_record" "root_wildcard_validation" {
  provider = "aws.root_domain"
  depends_on = ["aws_acm_certificate.env_wildcard"]
  allow_overwrite = true
  name     = "${lookup(aws_acm_certificate.env_wildcard.domain_validation_options[local.domain_root], "resource_record_name")}"
  type     = "${lookup(aws_acm_certificate.env_wildcard.domain_validation_options[local.domain_root], "resource_record_type")}"
  records  = ["${lookup(aws_acm_certificate.env_wildcard.domain_validation_options[local.domain_root], "resource_record_value")}"]
  zone_id  = "${data.aws_route53_zone.root_domain.zone_id}"
  ttl      = 60
}

resource "aws_acm_certificate_validation" "env_wildcard" {
  provider        = "aws.member"
  certificate_arn = "${aws_acm_certificate.env_wildcard.arn}"

  validation_record_fqdns = [
    "${aws_route53_record.env_wildcard_validation.fqdn}",
    "${aws_route53_record.parent_wildcard_validation.fqdn}",
    "${aws_route53_record.root_wildcard_validation.fqdn}",
  ]
}
