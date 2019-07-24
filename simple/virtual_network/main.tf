module "global" {
  source = "../global_variables"
}

variable "name" { default = "" }
variable "location" { default = "" }
variable "resource_group_name" { default = "" }
variable "address_space" { default = ["10.0.0.0/16"] }
variable "tags" { default = {} }

resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.name != "" ? var.name : format("%v-vnet-00", module.global.resource_group_name)}"
  location            = "${var.location != "" ? var.location : module.global.location}"
  resource_group_name = "${var.resource_group_name != "" ? var.resource_group_name : module.global.resource_group_name}"
  address_space       = "${var.address_space}"
  tags                = "${var.tags != "" ? var.tags : module.global.tags}"
}

output "name" {
  value = "${azurerm_virtual_network.virtual_network.name}"
}
