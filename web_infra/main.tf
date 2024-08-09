terraform {
  required_version = ">=0.12"
  #comment out to bootstrap the project with remote backend
  #     backend "azurerm" {
  #     resource_group_name  = var.resource_group_name      # The resource group where the storage account is located
  #     storage_account_name = var.storage_acc_name        # The name of the storage account
  #     container_name       = var.storage_acc_container_name # The name of the container
  #     key                  = "terraform.tfstate"          # The name of the state file within the container
  #   }

  backend "local" {
    path = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.client_information.subscription_id
  client_id       = var.client_information.client_id
  tenant_id       = var.client_information.tenant_id
  client_secret   = var.client_information.client_secret
}


locals {
  resource_group_name      = ""
  location                 = ""
  nic_ip_config_name       = "internal"
  vnet_name                = ""
  vnet_address_space       = ""
  subnet_cidr_blocks       = ""
  web_nsg_name             = ""
  db_nsg_name              = ""
  public_ip_addr_name      = ""
  load_balancer_name       = ""
  application_gateway_name = ""
  avs_name                 = ""
  sql_name                 = ""
  vm_name                  = ""
  web_vm_count             = 2
  zn_web_infra_backeup = {
    name = "zn-web-infra-backup"
    sku  = "Standard",
    backup = {
      frequency = "Daily"
      time      = "24:00"
    }
    retention_daily = {
      count = 10
    }
  }
}
