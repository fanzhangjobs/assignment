# Create a Subnet

resource "random_string" "azurerm_subnet_name" {
  length                        = 13
  lower                         = true
  numeric                       = false
  special                       = false
  upper                         = false
}

resource "azurerm_subnet" "aks-subnet" {
  name                          = coalesce(var.subnet_name, "subnet-${random_string.azurerm_subnet_name.result}")
  virtual_network_name          = var.virtual_network_name
  resource_group_name           = var.resource_group_name
  address_prefixes              = var.subnet_address_prefixes
}