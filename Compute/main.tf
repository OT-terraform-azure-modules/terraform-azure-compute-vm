data "azurerm_resource_group" "modular_rg" {
  name = var.resource_group_name
}

resource "azurerm_network_interface" "modular_nic" {
  for_each = { for key, nic in var.network_interfaces : key => nic }

  name                = each.value.name
  location            = data.azurerm_resource_group.modular_rg.location
  resource_group_name = data.azurerm_resource_group.modular_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "modular_vm" {
  for_each = { for key, vm in var.virtual_machines : key => vm }

  name                = each.value.name
  location            = data.azurerm_resource_group.modular_rg.location
  resource_group_name = data.azurerm_resource_group.modular_rg.name
  size                = each.value.size
  admin_username      = each.value.admin_username
  network_interface_ids = [azurerm_network_interface.modular_nic[each.value.nic_name].id]

  admin_ssh_key {
    username   = each.value.admin_username
    #public_key = file(each.value.ssh_key_path)
    public_key = each.value.ssh_key_path
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    #offer     = "UbuntuServer"
    offer      = each.value.offer
    #sku       = "22_04-lts-gen2"
    sku = each.value.sku_name
    version   = "latest"
  }
}
