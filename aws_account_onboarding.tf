module "aws_account" {
  source  = "illumio/cloudsecure/illumio//modules/aws_account"
  version = "1.5.1"
  name    = "Test Account"
  iam_name_prefix       = random_string.random.id
  tags    = {
    Name  = "CloudSecure Account Policy"
    Owner = "Engineering"
  }
}