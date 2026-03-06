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

variable "subnet_name" {
  description = "value of subnet name"
  type        = string
  default     = ""
}

variable "virtual_network_name" {
  description = "The name of the virtual network to place the subnet in"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "List of address prefixes in CIDR annotation reserved for the subnet"
  type        = list(string)
  #default     = ["10.240.0.0/16"]
}