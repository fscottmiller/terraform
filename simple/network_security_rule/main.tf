module "global" {
  source = "../global_variables"
}

# Required
variable "network_security_group_name" {}

# Optional
variable "resource_group_name" { default = "" }
variable "name" { default = "AllowEverything" }
variable "priority" { default = 1000 }
variable "direction" { default = "Outbound" }
variable "access" { default = "Allow" }
variable "protocol" { default = "*" }
variable "source_port_range" { default = "*" }
variable "destination_port_range" { default = "*" }
variable "source_address_prefix" { default = "*" }
variable "destination_address_prefix" { default = "*" }

resource "azurerm_network_security_rule" "network_security_rule" {
  name                        = "${var.name}"
  priority                    = "${var.priority}"
  direction                   = "${var.direction}"
  access                      = "${var.access}"
  protocol                    = "${var.protocol}"
  source_port_range           = "${var.source_port_range}"
  destination_port_range      = "${var.destination_port_range}"
  source_address_prefix       = "${var.source_address_prefix}"
  destination_address_prefix  = "${var.destination_address_prefix}"
  resource_group_name         = "${var.resource_group_name != "" ? var.resource_group_name : module.global.resource_group_name}"
  network_security_group_name = "${var.network_security_group_name}"
}
