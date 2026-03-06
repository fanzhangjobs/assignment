variable "resource_group_name" {
  description = "value of the resource group in Azure to deploy the resource into"
  type        = string
}

variable "location" {
  description = "value of azure region"
  type        = string
  default     = "westus"
}

variable "env" {
  description = "value of azure env"
  type        = string
  default     = "test"
}

variable "vnet_name" {
  description = "value of vnet name"
  type        = string
  default     = ""
}

variable "vnet_address_space" {
  description = "List of address spaces in CIDR annotation reserved for the vnet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}