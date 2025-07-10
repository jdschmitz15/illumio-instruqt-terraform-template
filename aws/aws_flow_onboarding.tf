

# module "aws_account_flowlogs" {
#   source  = "illumio/cloudsecure/illumio//modules/aws_account"
#   version = "1.5.1"
#   name    = "Test Account"
#   tags    = {
#     Name  = "CloudSecure Account Policy"
#     Owner = "Engineering"
#   }
# }

module "aws_flow_logs_s3_buckets" {
  source         = "illumio/cloudsecure/illumio//modules/aws_flow_logs_s3_buckets"
  version        = "1.5.1"
  role_id        = module.aws_account_onboarding.role_id
  iam_name_prefix       = local.account_id_prefix
  s3_bucket_arns = [
    "arn:aws:s3:::${local.storage_name}${random_id.random_id.hex}",
  ]

  depends_on = [aws_s3_bucket.s3bucket]
}