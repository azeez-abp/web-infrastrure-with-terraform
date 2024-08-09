variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "zn-web-infra-resource-group"
}

variable "location" {
  description = "The location/region name"
  type        = string
  default     = "eastus"
}

variable "storage_acc_name" {
  description = "The name of the storage account"
  type        = string
  default     = "znwebinfrastoacc"
}

variable "storage_acc_container_name" {
  description = "The name of the storage account"
  type        = string
  default     = "terraform-state"
}

variable "nic_ip_config_name" {
  description = "Network inter ip confic block name"
  type        = string
  default     = "internal"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "zn-web-infra-vnet"
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the subnets"
  type        = map(string)
  default = {
    web      = "10.0.1.0/24"
    database = "10.0.2.0/24"
  }
}


variable "web_nsg_name" {
  description = "Name of the Network security group"
  type        = string
  default     = "zn-web-infra-web-nsg"

}

variable "db_nsg_name" {
  description = "Name of the Network security group"
  type        = string
  default     = "zn-web-infra-db-nsg"

}


variable "public_ip_addr_name" {
  description = "Name of the public ip address"
  type        = string
  default     = "zn-web-infra-pubip"
}

variable "load_balancer_name" {
  description = "Name of load balancer"
  type        = string
  default     = "zn-web-infra-load-balancer"
}
variable "vm_name" {
  description = "Name of load balancer"
  type        = string
  default     = "zn-web-infra-webvm"
}

variable "application_gateway_name" {
  description = "Name of load application gateway"
  type        = string
  default     = "zn-web-infra-app-ga"
}

variable "avs_name" {
  description = "Name of load application gateway"
  type        = string
  default     = "zn-web-infra-avs"
}

variable "sql_name" {
  description = "Name of load application gateway"
  type        = string
  default     = "zn-web-infra-sql"
}


variable "web_vm_count" {
  description = "The number of web VM pool"
  type        = number
  default     = 2
}

variable "zn_web_infra_backeup" {
  description = "variables for backup resources"
  type = object({
    name = string
    sku  = string
    backup = object({
      frequency = string
      time      = string
    })

    retention_daily = object({
      count = number
    })

  })
  default = {
    name = "zn-web-infra-backup"
    sku  = "Standard",
    backup = {
      frequency = "Daily"
      time      = "23:00"
    }
    retention_daily = {
      count = 10
    }
  }

}

variable "vm_db_login_credentials" {
  type = object({
    user1 = string
    pass1 = string
    user = string
    pass = string
  })

  sensitive = true
}
variable "client_information" {
  type = object({
    subscription_id = string
    client_id       = string
    tenant_id       = string
    client_secret   = string
  })
  sensitive = true

  validation {
    condition = (
      length(var.client_information.subscription_id) > 0 &&
      length(var.client_information.client_id) > 0 &&
      length(var.client_information.tenant_id) > 0 &&
      length(var.client_information.client_secret) > 0
    )
    error_message = "All credentials details are required"
  }
}

