module "global" {
  source = "../global_variables"
}

resource "azurerm_virtual_machine_data_disk_attachment" "connector" {
  count              = "${var.nb_disks}"
  managed_disk_id    = "${element(azurerm_managed_disk.disk.*.id, count.index)}"
  virtual_machine_id = "${azurerm_virtual_machine.vm.id}"
  lun                = "${count.index}"
  caching            = "ReadWrite"
}
