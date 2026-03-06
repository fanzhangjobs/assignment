# Create Azure Container Registry

resource "random_string" "azurerm_acr_name" {
  length                        = 13
  lower                         = true
  numeric                       = false
  special                       = false
  upper                         = false
}

resource "azurerm_container_registry" "acr" {
  name                = coalesce(var.azurerm_container_registry_name, "acr${random_string.azurerm_acr_name.result}")
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled

  tags = {
    environment = var.env
  }

  lifecycle {
    ignore_changes = [
      admin_enabled
    ]
  }
}

resource "azurerm_role_assignment" "acr_k8s_assignment" {

 count = var.kubelet_identity_object_id == "" ? 0 : 1

  principal_id                     = var.kubelet_identity_object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = var.skip_service_principal_aad_check
}