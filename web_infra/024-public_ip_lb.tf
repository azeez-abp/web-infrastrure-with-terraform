# create a static ip address for load balancer, so that ip does not change when vm is restarted
resource "azurerm_public_ip" "zn_web_infra_pubip_lb" {
  name                = "${var.public_ip_addr_name}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
