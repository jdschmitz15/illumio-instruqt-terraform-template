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
      name                = azurerm_storage_account.flowlogs.name
      resource_group_name = azurerm_resource_group.rg.name
    },
  ]
}