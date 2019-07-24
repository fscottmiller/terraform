module "global" {
  source = "../global_variables"
}

variable "name" { default = "" }
variable "location" { default = "" }
variable "resource_group_name" { default = "" }
variable "private_ip_address_allocation" { default = "Dynamic" }
variable "network_security_group_id" {}
variable "subnet_id" {}
variable "public_ip_address_id" {}
variable "tags" { default = {} }

resource "azurerm_network_interface" "nic" {
  name                      = "${var.name != "" ? var.name : module.global.name}"
  location                  = "${var.location != "" ? var.location : module.global.location}"
  resource_group_name       = "${var.resource_group_name != "" ? var.resource_group_name : module.global.resource_group_name}"
  network_security_group_id = "${var.network_security_group_id}"
  ip_configuration {
    name                          = "${name}-ip-config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "${var.private_ip_address_allocation}"
    public_ip_address_id          = "${var.public_ip_address_id}"
  }
  tags = "${var.tags != {} ? var.tags : module.global.tags}"
}
