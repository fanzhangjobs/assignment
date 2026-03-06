variable "env" {
  description = "value of env"
  type        = string
  default     = "testing"
}

variable "location" {
  description = "value of azure region"
  type        = string
}

variable "azurerm_container_registry_name" {
  description = "value of container registry name" # can only consist of lowercase letters and numbers
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "value of the resource group in Azure to deploy resource into"
  type        = string
}

variable "sku" {
  description = "value of the sku tier to use for the container registry"
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Should admin be enabled for the container registry"
  type        = bool
  default     = true
}

variable "kubelet_identity_object_id" {
  description = "Kubelet identity object ID if we shall allow pulls from k8s"
  type        = string
  default     = ""
}

variable "skip_service_principal_aad_check" {
  description = "If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory."
  type        = bool
  default     = false
}
