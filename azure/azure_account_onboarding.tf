module "azure_subscription_onboarding" {
  source                 = "illumio/cloudsecure/illumio//modules/azure_subscription"
  version                = "1.5.1"
  name                   = "Instruqt Azure Subscription"
  mode                   = "ReadWrite"
  iam_name_prefix       = "${local.account_id_prefix}${random_id.random_id.hex}"
}