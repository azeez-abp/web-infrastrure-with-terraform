
resource "azurerm_virtual_machine" "web" {
  count               = var.web_vm_count
  name                = "web-vm-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  availability_set_id = azurerm_availability_set.web.id
  network_interface_ids = [
    azurerm_network_interface.web[count.index].id,
  ]
  vm_size = "Standard_D2s_v3"
  storage_os_disk {
    name              = "web-os-disk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 128
  }
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  os_profile {
    computer_name  = "${var.vm_name}-${count.index}"
    admin_username = var.vm_db_login_credentials.user1
    admin_password = var.vm_db_login_credentials.pass1
  }
  os_profile_windows_config {}
}

resource "azurerm_virtual_machine" "database" {
  name                = "zn-web-infra-db"
  resource_group_name = var.load_balancer_name
  location            = var.location
  network_interface_ids = [
    azurerm_network_interface.database.id,
  ]
  vm_size = "Standard_D4s_v3"
  storage_os_disk {
    name              = "database-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 256
  }
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  os_profile {
    computer_name  = "database-vm"
    admin_username = var.vm_db_login_credentials.user
    admin_password = var.vm_db_login_credentials.pass
  }
  os_profile_windows_config {}
}