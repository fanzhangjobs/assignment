
variable "env" {
  description = "value of env"
  type        = string
  default     = "test"
}

variable "project_name" {
  description = "value of the resource group in Azure to deploy the resource into"
  type        = string
  default     = "test"
}

variable "region" {
  description = "value of azure region"
  type        = string
  default     = "westus"
}


variable "azvm_subnet_address_prefixes" {
  description = "subnet cidr"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

