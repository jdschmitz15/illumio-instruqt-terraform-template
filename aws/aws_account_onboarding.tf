module "aws_account_onboarding" {
  source  = "illumio/cloudsecure/illumio//modules/aws_account"
  version = "1.5.1"
  name    = "Instruqt AWS Account"
  iam_name_prefix       = local.account_id_prefix
  tags    = {
    Name  = "CloudSecure Account Policy"
    Owner = "Engineering"
  }
}