module "global" {
  source = "../global_variables"
}

variable "name" { default = "" }
variable "resource_group_name" { default = "" }
variable "location" { default = "" }
variable "storage_account_type" { default = "Premium_LRS" }
variable "create_option" { default = "Empty" }
variable "disk_size_gb" { default = 128 }
variable "tags" { default = {} }

resource "azurerm_managed_disk" "disk" {
  name                 = "${var.name != "" ? var.name ? module.global.name}"
  location             = "${var.location != "" ? var.location : module.global.location}"
  resource_group_name  = "${var.resource_group_name != "" ? var.resource_group_name : module.global.resource_group_name}"
  storage_account_type = "${var.storage_account_type}"
  create_option        = "${var.create_option}"
  disk_size_gb         = "${var.disk_size_gb}"
  tags                 = "${var.tags != {} ? var.tags : module.global.tags}"
}

output "id" { value = "${azurerm_managed_disk.disk.id}" }
