# This file contains the  implementation of subnets, the subnet is created by looping through thesubnet_cidr_blocks
resource "azurerm_subnet" "zn_web_infra_subnets" {
  for_each             = var.subnet_cidr_blocks
  name                 = "${each.key}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.zn_web_infra_vnet.name
  address_prefixes     = [each.value]
}
