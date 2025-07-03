# module "azure_subscription_flowlogs" {
#   source                 = "illumio/cloudsecure/illumio//modules/azure_subscription"
#   version                = "1.5.1"
#   name                   = "Test Azure Subscription"
#   mode                   = "ReadWrite"
#   iam_name_prefix       = random_string.random.id
#   tags = [
#     "Environment=Dev",
#     "Owner=John Doe"
#   ]
# }

module "azure_flow_logs_storage_accounts" {
  source                      = "illumio/cloudsecure/illumio//modules/azure_flow_logs_storage_accounts"
  version                     = "1.5.1"
  service_principal_client_id = module.azure_subscription_onboarding.service_principal_client_id
  iam_name_prefix       = local.account_id_prefix
  storage_accounts = [
    {
      name                = local.storage_name
      resource_group_name = "instruqttestdrive"
    }
  ]
  depends_on = [azurerm_storage_account.flowlogs ]
}