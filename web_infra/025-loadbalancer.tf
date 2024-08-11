resource "azurerm_lb" "zn_web_infra_lb" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = azurerm_public_ip.zn_web_infra_pubip_lb.id
  }
}


resource "azurerm_lb_backend_address_pool" "loadbalance_addr" {
  loadbalancer_id = azurerm_lb.zn_web_infra_lb.id
  name            = "backendPool"
  # Ensure loadbalancer and availability set are created before this
  depends_on = [azurerm_lb.zn_web_infra_lb, azurerm_availability_set.web]
}

resource "azurerm_network_interface_backend_address_pool_association" "backend_pool_assoc" {
  count                   = var.web_vm_count
  network_interface_id    = azurerm_network_interface.web[count.index].id
  backend_address_pool_id = azurerm_lb_backend_address_pool.loadbalance_addr.id
  ip_configuration_name   = "ipconfig"

}

resource "azurerm_lb_probe" "lb_probe" {
  name                = "lbProbe"
  loadbalancer_id     = azurerm_lb.zn_web_infra_lb.id
  port                = 80
  protocol            = "Tcp"
  interval_in_seconds = 15
  number_of_probes    = 2
}


resource "azurerm_lb_rule" "zn_web_infra_lb_rule_01" {
  loadbalancer_id                = azurerm_lb.zn_web_infra_lb.id
  name                           = "lb-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend"
  probe_id                       = azurerm_lb_probe.lb_probe.id
}

