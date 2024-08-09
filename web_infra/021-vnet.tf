# this file contains the  implementation of Vnet which the whole address space of the network
resource "azurerm_virtual_network" "zn_web_infra_vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}