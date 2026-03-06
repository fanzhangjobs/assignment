locals {
  # Parse the file path we're in to read the env name: e.g., env 
  # will be "dev" in the dev folder, "stage" in the stage folder, 
  # etc.
  env               = "${basename(path_relative_to_include())}"

  # Envs for Service Principal
  subscription_id = "3dafc302-f265-466f-8938-9ca1e9ab8047"
  client_id       = "cff429af-4c62-4329-84bb-f441cd83c6f1" # appID
  tenant_id       = "2d538578-3a5d-42d0-acf3-fa5237c6ca9c"
  client_secret   = get_env("AZURE_CLIENT_SECRET") # Password
}

remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    resource_group_name  = "terraform"
    storage_account_name = "terragstore"
    container_name       = "terraform-${local.env}"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF

terraform {
  required_providers {
    azapi = {
       source  = "Azure/azapi"
       version = "=1.13.1"
     }

    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.50.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.104.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    flux = {
      source = "fluxcd/flux"
      version = "1.3.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "=2.30.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }

    cognitive_account {
      purge_soft_delete_on_destroy = true
    }
  }

  disable_terraform_partner_id = true
  skip_provider_registration   = true

  subscription_id = "${local.subscription_id}"
  client_id       = "${local.client_id}"
  client_secret   = "${local.client_secret}"
  tenant_id       = "${local.tenant_id}"
}

provider "azapi" {
}

provider "flux" {
  kubernetes = {
    config_path = var.kubeconfig_file
  }
  git = {
    url = var.flux_git_url
    branch = var.flux_repo_branch
    http = {
      username = var.flux_user
      password = var.flux_token
    }
  }
}

provider "kubectl" {
  config_path = var.kubeconfig_file
}

provider "kubernetes" {
  config_path = var.kubeconfig_file
}

EOF
}