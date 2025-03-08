data "azurerm_resource_group" "modular_rg" {
  name = var.resource_group_name
}

module "compute" {
  source              = "../Compute"
  resource_group_name = data.azurerm_resource_group.modular_rg.name
  location            = data.azurerm_resource_group.modular_rg.location
  network_interfaces   = var.network_interfaces
  virtual_machines     = var.virtual_machines
}
