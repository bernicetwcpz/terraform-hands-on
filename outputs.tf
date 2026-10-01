output "bucket_arn" {
  value = one(aws_s3_bucket.app[*].arn)
}

output "ssm_parameter_arn" {
  value = aws_ssm_parameter.environment.arn
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}