terraform {
  required_version = ">=0.12"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}


provider "azurerm" {
  features {}

  client_id       = "fa925402-f184-4c57-9810-f5f47ab043a4"
  client_secret   = ""
  tenant_id       = "2d538578-3a5d-42d0-acf3-fa5237c6ca9c"
  subscription_id = "3dafc302-f265-466f-8938-9ca1e9ab8047"
}
