variable "env" {
  description = "value of env"
  type        = string
  default     = "testing"
}

variable "location" {
  description = "value of azure region"
  type        = string
}

variable "resource_group_name" {
  description = "value of the resource group in Azure to deploy the resource into"
  type        = string
}