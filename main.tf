locals {
  parent_zone = "${length(split("-", var.account_name)) > 1
    ? "${replace(var.account_name, "/.*-/", "")}.${var.top_level_domain}"
    : "${var.top_level_domain}"
  }"
}
