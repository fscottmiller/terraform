module "rg" {
  source = "../../simple/resource_group"
}

module "vnet" {
  source = "../../simple/virtual_network"
}

module "subnet" {
  source               = "../../simple/subnet"
  virtual_network_name = module.vnet.name
}

module "network_security_group" {
  source = "../../simple/network_security_group"
}

module "network_security_rule" {
  source                      = "../../simple/network_security_rule"
  network_security_group_name = module.network_security_group.name
}
