terraform {
  required_version = ">=0.12"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }  
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = ">= 1.0.11"
    }
  }
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}


provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

provider "azuread" {
}

locals  {
  # Extract the account ID prefix from the variable and create a bucket name
  account_id_prefix = replace(split("@", var.account_id)[0],"+","")
  storage_name = "instruqtholflowlogs${local.account_id_prefix}"
}