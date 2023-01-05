//
// Variables specific to module label
//
variable "availability_zones" {
  description = "List of AZ letters to use"
  type        = "list"
  default     = ["a", "b", "c"]
}

variable "aws_region" {
  description = "AWS region to manage resources in"
}

variable "environment" {
  description = "Environment (ex: `dev`, `qa`, `stage`, `prod`). (Second or top level namespace. Depending on namespacing options)"
}

variable "organization" {
  description = "Organization namespace"
}

variable "account_name" {
  description = "Name of member account. Format: namespace-account. Part after - is used for DNS subdomain"
}

variable "component" {
  description = "Tag: Component"
  default     = "vpc"
}

variable "product" {
  description = "Tag: Product"
  default     = "shared"
}

variable "name" {
  description = "Tag: Name"
  default     = "vpc"
}

variable "service" {
  description = "Tag: Service"
  default     = "vpc"
}

variable "team" {
  description = "Tag: Team"
  default     = "devops"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`Cluster`,`XYZ`)"
}

variable "top_level_domain" {
  description = "Top level DNS domain. Account subdomain will be added to this"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = "string"
}

variable "vpc_name" {
  description = "Name of VPC"
}

variable "private_acl_cidr" {
  description = "Private Subnet acl ingress CIDR"
  default     = "10.0.0.0/8"
}
