# Create Virtual Network

resource "random_string" "azurerm_vnet_name" {
  length                        = 13
  lower                         = true
  numeric                       = false
  special                       = false
  upper                         = false
}

resource "azurerm_virtual_network" "vnet" {
  name                = coalesce(var.vnet_name, "vnet-${random_string.azurerm_vnet_name.result}")
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
}