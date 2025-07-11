resource "aws_s3_bucket" "s3bucket" { 
  bucket = local.storage_name
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

