# this file contains the  implementation of network security group which filter traffic into the network
resource "azurerm_network_security_group" "zn_web_infra_nsg" {
  name                = var.web_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "database" {
  name                = var.db_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                   = "allow-sql"
    priority               = 100
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "1433"
    # only the web subnet can reach the database subnet
    source_address_prefix      = lookup(azurerm_subnet.zn_web_infra_subnets, "web", null).address_prefixes[0]
    destination_address_prefix = "*"
  }
}



# Associate NSGs with Subnets
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.zn_web_infra_subnets["web"].id
  network_security_group_id = azurerm_network_security_group.zn_web_infra_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "database_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.zn_web_infra_subnets["database"].id
  network_security_group_id = azurerm_network_security_group.database.id
}