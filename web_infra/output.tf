output "subnet_ids" {
  value = { for s in azurerm_subnet.zn_web_infra_subnets : s.name => s.id }
}

# output "data" {
#   value = data.azurerm_client_config.user
# }

output "web_vm_ips" {
  value = [for vm in azurerm_virtual_machine.web : vm.name]
}

output "database_server" {
  value = azurerm_mssql_server.zn_web_infra_sql_server.fully_qualified_domain_name
}

output "resource_group_name" {
  value = azurerm_resource_group.zn_web_infra_rg.name
}