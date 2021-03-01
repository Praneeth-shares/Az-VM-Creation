
data "azurerm_resource_group" "DemoRG" {
  name     = var.resourceG
}


data "azurerm_subnet" "AZsubnet" {
  name                 = var.subnet
  virtual_network_name = data.azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_resource_group.DemoRG.name

}

data "azurerm_virtual_network" "main" {
  name                = var.vnet
  resource_group_name = data.azurerm_resource_group.DemoRG.name
}