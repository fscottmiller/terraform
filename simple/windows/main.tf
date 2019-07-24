module "global" {
  source = "../global_variables"
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.name}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = ["${azurerm_network_interface.nic.id}"]
  vm_size               = "${var.vm_size}"
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "USE2-TGOVAPP007-os-01"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
  os_profile {
    computer_name  = "${var.name}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }
  os_profile_windows_config {
  }
  tags = "${merge(local.common_tags, local.extra_tags)}"
}
