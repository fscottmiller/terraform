module "global" {
  source = "../global_variables"
}

resource "azurerm_public_ip" "ip" {
  domain_name_label   = "${var.name}"
  name                = "${var.name}-pip-01"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  allocation_method   = "Dynamic"
  tags                = "${merge(local.common_tags, local.extra_tags)}"
}
