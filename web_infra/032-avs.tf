
# this is the defination for web vm availability set, the web vm will reference this  azurerm_availability_set.web.id
resource "azurerm_availability_set" "web" {
  name                = var.avs_name
  location            = var.location
  resource_group_name = var.resource_group_name
  #sku                 = "Aligned"
}