resource "aws_s3_bucket" "app" {
  bucket = "${var.prefix}-terraform-example"
}

resource "aws_sqs_queue" "jobs" {
  name = "${var.prefix}-terraform-jobs"
}

resource "aws_dynamodb_table" "items" {
  name         = "${var.prefix}-terraform-items"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_ssm_parameter" "environment" {
  name  = "/${var.prefix}/environment"
  type  = "String"
  value = var.environment
}