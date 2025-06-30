terraform {
  required_version = ">=0.12"
  required_providers {
    # azapi = {
    #   source  = "azure/azapi"
    #   version = "~>1.5"
    # }
    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "~>2.0"
    # }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
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

provider "aws" {
  region = "us-east-1" 
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

provider "azuread" {
}