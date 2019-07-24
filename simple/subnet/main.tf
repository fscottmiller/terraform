module "global" {
  source = "../global_variables"
}

# Required
variable "virtual_network_name" {}

# Optional
variable "name" { default = "" }
variable "resource_group_name" { default = "" }
variable "address_prefix" { default = "10.0.0.0/24" }

resource "azurerm_subnet" "subnet" {
  name                 = "${var.name != "" ? var.name : format("%v-subnet-00", module.global.resource_group_name)}"
  resource_group_name  = "${var.resource_group_name != "" ? var.resource_group_name : module.global.resource_group_name}"
  virtual_network_name = "${var.virtual_network_name}"
  address_prefix       = "${var.address_prefix}"
}
