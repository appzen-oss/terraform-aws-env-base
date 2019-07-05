//
// Setup management VPC for infrastructure services
//
# Make this optional
# Only environment accounts need this
# Keep same ip pattern in all accounts

# TODO:
#   add tags to subnets, route tables: public|private
#   avail zones should be a variable or lookup
#   variable region

module "vpc" {
  source     = "cloudposse/vpc/aws"
  version    = "0.3.5"
  namespace  = "${var.organization}"
  stage      = "${replace(var.account_name, "/.*-/", "")}"
  name       = "${var.environment}"
  cidr_block = "${var.vpc_cidr}"
  tags       = "${map("Environment", "${var.environment}")}"

  providers = {
    aws = "aws.member"
  }
}

# TODO: look into just specifing number of subnets
locals {
  availability_zones = ["${formatlist("${var.aws_region}%s", var.availability_zones)}"]
}

module "dynamic_subnets" {
  #source             = "cloudposse/dynamic-subnets/aws"
  #version            = "0.3.8"
  source = "git::https://github.com/appzen-oss/terraform-aws-dynamic-subnets.git?ref=master"

  namespace          = "${var.organization}"
  stage              = "${replace(var.account_name, "/.*-/", "")}"
  name               = "${var.environment}"
  region             = "${var.aws_region}"
  availability_zones = ["${local.availability_zones}"]
  vpc_id             = "${module.vpc.vpc_id}"
  igw_id             = "${module.vpc.igw_id}"
  cidr_block         = "${module.vpc.vpc_cidr_block}"

  providers = {
    aws = "aws.member"
  }
}

/**/
/*
data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  provider             = "aws.member"
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.vpc_name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  num_azs    = "3" # -> 4 ?
  azs_string = "${join(",", slice(data.aws_availability_zones.available.names, 0, local.num_azs))}"
}

module "public_subnet" {
  source = "git::ssh://git@bitbucket.org/appzeneng/terrazen_library.git//Modules/public_subnet"
  name   = "${var.vpc_name}-public-subnet"
  vpc_id = "${aws_vpc.vpc.id}"
  cidrs  = "${var.public_subnet_cidrs}"
  azs    = "${local.azs_string}"

  providers = {
    aws = "aws.member"
  }
}

resource "aws_eip" "nat" {
  provider = "aws.member"
  count    = "${local.num_azs}"
  vpc      = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat" {
  provider      = "aws.member"
  count         = "${local.num_azs}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(split(",", module.public_subnet.subnet_ids), count.index)}"

  lifecycle {
    create_before_destroy = true
  }
}

module "networking_private_subnet" {
  source          = "git::ssh://git@bitbucket.org/appzeneng/terrazen_library.git//Modules/private_subnet"
  name            = "${var.vpc_name}-private-subnet"
  vpc_id          = "${aws_vpc.vpc.id}"
  cidrs           = "${var.private_subnet_cidrs}"
  azs             = "${local.azs_string}"
  nat_gateway_ids = "${join(",", aws_nat_gateway.nat.*.id)}"

  providers = {
    aws = "aws.member"
  }
}

/**/
