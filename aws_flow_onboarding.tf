

module "aws_account_flowlogs" {
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
  role_id        = module.aws_account_dev.role_id
  s3_bucket_arns = [
    aws_s3_bucket.s3bucket.arn,
  ]

  depends_on = [aws_s3_bucket.s3bucket]
}