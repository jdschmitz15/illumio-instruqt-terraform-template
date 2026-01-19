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
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
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



#Script at the end goes and get a traffic generator tool that simulates traffic for demo purposes.  It uses a static csv to create the traffic.
locals  {
  # Extract the account ID prefix from the variable and create a bucket name
  account_id_prefix = substr(replace(replace(split("@", var.account_id)[0], "+", ""), "-", ""), 0, 22)
  storage_name = "sa${local.account_id_prefix}"
  startupscript = <<CUSTOM_DATA
#!/bin/bash
sudo apt install unzip -y
#get the traffic-generator application and make it executable
curl -L https://github.com/brian1917/traffic-generator/releases/download/v1.0.5/linux_amd64.zip -o tg.zip
unzip ./tg.zip 
chmod +x ./linux_amd64/traffic-generator
#get the base traffic file 
curl -L https://raw.githubusercontent.com/jdschmitz15/manual-instruqt-startup/refs/heads/main/traffic.csv -o ./linux_amd64/traffic.csv
#Run the traffic generator with the traffic file downloaded in headless mode
./linux_amd64/traffic-generator continuous ./linux_amd64/traffic.csv  > /dev/null 2>&1 &
CUSTOM_DATA
}