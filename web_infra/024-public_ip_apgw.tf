# create a static ip address for application gateway, so that ip does not change when vm is restarted
resource "azurerm_public_ip" "zn_web_infra_pubip_apgw" {
  name                = "${var.public_ip_addr_name}-appgw"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

