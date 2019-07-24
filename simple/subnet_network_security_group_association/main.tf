module "global" {
  source = "../global_variables"
}

variable "subnet_id" {}
variable "network_security_group_id" {}

resource "azurerm_subnet_network_security_group_association" "test" {
  subnet_id                 = "${var.subnet_id}"
  network_security_group_id = "${var.network_security_group_id}"
}
