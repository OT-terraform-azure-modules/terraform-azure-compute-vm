variable "resource_group_name" {
  description = "Existing Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region for deployment."
  type        = string
}

variable "network_interfaces" {
  description = "Map of network interfaces to be created."
  type = map(object({
    name     = string
    subnet_id = string
  }))
}

variable "virtual_machines" {
  description = "Map of Linux VMs to be provisioned."
  type = map(object({
    name           = string
    size           = string
    admin_username = string
    nic_name       = string
    ssh_key_path   = string
    disk_name      = string
    storage_account_type  = string
    disk_size_gb   = number
    offer          = string
    sku_name       = string
  }))
}
