output "bucket_arn" {
    value = aws_s3_bucket.app.arn
}

output "ssm_parameter_arn" {
    value = aws_ssm_parameter.environment.arn
}