
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

provider "azuread" {
}
provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret
}

module "azure_subscription_dev" {
  source                 = "illumio/cloudsecure/illumio//modules/azure_subscription"
  version                = "1.5.1"
  name                   = "Test Azure Subscription"
  mode                   = "ReadWrite"
  tags = [
    "Environment=Dev",
    "Owner=John Doe"
  ]
}

module "azure_flow_logs_storage_accounts" {
  source                      = "illumio/cloudsecure/illumio//modules/azure_flow_logs_storage_accounts"
  version                     = "1.5.1"
  service_principal_client_id = module.azure_subscription_dev.service_principal_client_id

  storage_accounts = [
    {
      name                = "welcomegsk"
      resource_group_name = "demo1"
    },
    {
      name                = "secondstorage"
      resource_group_name = "demo2"
    },
    {
      name                = "thirdstorage"
      resource_group_name = "demo3"
    }
  ]
}