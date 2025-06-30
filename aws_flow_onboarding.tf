data "aws_iam_role" "illumio" {
  name = "IllumioCloudIntegrationRole"
}

module "aws_account_dev" {
  source  = "illumio/cloudsecure/illumio//modules/aws_account"
  version = "1.5.1"
  name    = "Test Account"
  tags    = {
    Name  = "CloudSecure Account Policy"
    Owner = "Engineering"
  }
}

module "aws_flow_logs_s3_buckets" {
  source         = "illumio/cloudsecure/illumio//modules/aws_flow_logs_s3_buckets"
  version        = "1.5.1"
  role_id        = data.aws_iam_role.illumio.id
  s3_bucket_arns = [
    aws_s3_bucket.s3bucket.arn
  ]
}