# this file contains the  implementation of NIC which send and receive packet 
# it is attached to subnet 

# each of the NICs at web subnet will assign ip to vm in the subnet
resource "azurerm_network_interface" "web" {
  count               = var.web_vm_count # each VM requires its own NIC
  name                = "web-network-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.nic_ip_config_name
    subnet_id                     = azurerm_subnet.zn_web_infra_subnets["web"].id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_network_interface" "database" {
  name                = "db-nework-interface"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.zn_web_infra_subnets["database"].id
    private_ip_address_allocation = "Dynamic"
  }
}
