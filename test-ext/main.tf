provider "azurerm" {
  version         = "~> 1.3"
  tenant_id       = "28e5a145-70c6-44e3-ba17-7b09d54fe531"
  subscription_id = "1c7dd6a5-8062-4996-a076-5eda5f1e2d1a"
  client_secret   = "*6qILW?n419OUif/@gB]G-Vg8j7_RRf5"
  client_id       = "7882d880-565c-44f7-be03-dc0c2e5ab73f"
}

resource "azurerm_resource_group" "rg" {
  # count = "${data.azurerm_resource_group.rg_data.id != "" ? 1 ? 0}"
  name     = "test-deploying"
  location = "East US 2"
  tags     = { foo = "bar" }
}

module "windows" {
  source              = "/home/scott/Desktop/cloud/terraform/azure-terraform/modules/specify_os_image"
  subnet_id           = "/subscriptions/1c7dd6a5-8062-4996-a076-5eda5f1e2d1a/resourceGroups/devops-thinmint-poc/providers/Microsoft.Network/virtualNetworks/thinmint-vnet/subnets/thinmint-subnet"
  name                = "eu2-tgovapp-001"
  vm_os_simple        = "WindowsServer"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  tags                = { foo = "bar" }
  nb_disks            = 2
  nb_instances        = 2
  location            = "East US 2"
  nsg_id              = "${module.nsg.id}"
}

module "bginfo" {
  source               = "/home/scott/Desktop/cloud/terraform/azure-terraform/modules/vm_extension"
  name                 = "bginfo"
  location             = "${azurerm_resource_group.rg.location}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  vm_name              = "${module.windows.name}"
  type                 = "BGInfo"
  type_handler_version = "2.1"
  publisher            = "Microsoft.Compute"
}

module "nsg" {
  source              = "/home/scott/Desktop/cloud/terraform/azure-terraform/modules/network_security_group"
  name                = "test-deploy-multiple"
  location            = "East US 2"
  tags                = { foo = "bar" }
  resource_group_name = "${azurerm_resource_group.rg.name}"
  # allowed_ports       = ["8080"]
}
