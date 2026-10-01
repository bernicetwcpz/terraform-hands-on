data "aws_caller_identity" "current" {}

locals {
  standard_naming_prefix = "${var.prefix}-terraform"
}


resource "aws_s3_bucket" "app" {
  count  = var.create_s3_bucket ? 1 : 0
  bucket = "${local.standard_naming_prefix}-example"

}

resource "aws_sqs_queue" "jobs" {
  name = "${local.standard_naming_prefix}-jobs"
}

resource "aws_dynamodb_table" "items" {
  name         = "${local.standard_naming_prefix}-items"
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