module "global" {
  source = "../global_variables"
}

variable "name" { default = "" }
variable "location" { default = "" }
variable "resource_group_name" { default = "" }
variable "tags" { default = {} }

resource "azurerm_network_security_group" "security_group" {
  name                = "${var.name != "" ? var.name : format("%s-nsg-00", module.global.resource_group_name)}"
  location            = "${var.location != "" ? var.location : module.global.location}"
  resource_group_name = "${var.resource_group_name != "" ? var.resource_group_name : module.global.resource_group_name}"
  tags                = "${var.tags != {} ? var.tags : module.global.tags}"
}

output "name" {
  value = "${azurerm_network_security_group.security_group.name}"
}
