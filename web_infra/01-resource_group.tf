# this file contains the  implementation of resource group that receive request for provisioning infrastrucutre
resource "azurerm_resource_group" "zn_web_infra_rg" {
  name     = var.resource_group_name
  location = var.location
}

# the storage for remote backend and log stoaget
resource "azurerm_storage_account" "zn_web_infra_storage_acc" {
  name                     = var.storage_acc_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# storage container for storing terraform state file
resource "azurerm_storage_container" "zn_web_infra_storage_container" {
  name                  = var.storage_acc_container_name
  storage_account_name  = azurerm_storage_account.zn_web_infra_storage_acc.name
  container_access_type = "private"
}
