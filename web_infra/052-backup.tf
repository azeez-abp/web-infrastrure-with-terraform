# This file provisionn the backup for vms

resource "azurerm_recovery_services_vault" "zn_web_infra_backeup" {
  name                = "${var.zn_web_infra_backeup.name}-vault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "${var.zn_web_infra_backeup.sku}"
}

resource "azurerm_backup_policy_vm" "zn_web_infra_backeup_policy" {
  name                = "t${var.zn_web_infra_backeup.name}-policy"
  resource_group_name =  var.resource_group_name
  recovery_vault_name =  azurerm_recovery_services_vault.zn_web_infra_backeup.name

  backup {
    frequency = var.zn_web_infra_backeup.backup.frequency
    time      = var.zn_web_infra_backeup.backup.time
  }
  retention_daily {
    count = var.zn_web_infra_backeup.retention_daily.count
  }
}


# Backup the two vm
data "azurerm_virtual_machine" "web" {
  count               = var.web_vm_count
  name                = azurerm_virtual_machine.web[count.index].name
  resource_group_name = var.resource_group_name
}

resource "azurerm_backup_protected_vm" "web_vms" {
  count               = var.web_vm_count
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.zn_web_infra_backeup.name
  source_vm_id        = data.azurerm_virtual_machine.web[count.index].id
  backup_policy_id    = azurerm_backup_policy_vm.zn_web_infra_backeup_policy .id
}

# Backuo the database vm
data "azurerm_virtual_machine" "database" {
  name                = azurerm_virtual_machine.database.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_backup_protected_vm" "db_vms" {
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.zn_web_infra_backeup.name
  source_vm_id        = data.azurerm_virtual_machine.database.id
  backup_policy_id    = azurerm_backup_policy_vm.zn_web_infra_backeup_policy .id
}
