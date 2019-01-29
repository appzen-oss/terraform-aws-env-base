locals {
  parent_zone = "${replace(var.account_name, "/.*-/", "")}.${var.top_level_domain}"
}
