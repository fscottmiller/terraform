variable "name" {}
variable "location" {}
variable "tags" { default = {} }

resource "azurerm_resource_group" "rg" {
  name     = "${var.name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}
