locals  {
  # Extract the account ID prefix from the variable and create a bucket name
  account_id_prefix = replace(split("@", var.account_id)[0],"+","")
  bucket_name = "us-east-1-flow-logs-${local.account_id_prefix}"
} 
resource "random_string" "random" {
  length  = 8
  lower   = true
  numeric = true
  special = false
  upper   = false
}
resource "aws_s3_bucket" "s3bucket" { 
  bucket = local.bucket_name
  force_destroy = true
}


resource "aws_flow_log" "flowlogs1" {
  vpc_id            = aws_vpc.vpc1.id
  log_destination   = aws_s3_bucket.s3bucket.arn
  log_destination_type = "s3"
  traffic_type      = "ALL"

  tags = {
    Name = "Flow-logs1"
  }
}

resource "aws_flow_log" "flowlogs2" {
  vpc_id            = aws_vpc.vpc2.id
  log_destination   = aws_s3_bucket.s3bucket.arn
  log_destination_type = "s3"
  traffic_type      = "ALL"

  tags = {
    Name = "Flow-logs2"
  }
}

