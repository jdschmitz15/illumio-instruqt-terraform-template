terraform {
  required_version = ">=0.12"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = ">=1.5"
    }  
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = ">= 1.0.11"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret

  request_timeout = "60s"
}


provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

provider "azuread" {
}

# # Generate random text for a unique storage account name
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg.name
  }

  byte_length = 8
}


locals  {
  # Extract the account ID prefix from the variable and create a bucket name
  account_id_prefix = substr(replace(replace(split("@", var.account_id)[0], "+", ""), "-", ""), 0, 22)
  #account_id_prefix = replace(split("@", var.account_id)[0],"+","")
  #storage_name = "instruqtsa${local.account_id_prefix}${random_id.random_id.hex}"
  storage_name = "sa${local.account_id_prefix}"
}