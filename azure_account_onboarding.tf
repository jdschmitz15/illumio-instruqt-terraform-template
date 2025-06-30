module "azure_subscription" {
  source                 = "illumio/cloudsecure/illumio//modules/azure_subscription"
  version                = "1.5.1"
  name                   = "Instruqt Azure Subscription"
  mode                   = "ReadWrite"
  iam_name_prefix        = var.account_id
}