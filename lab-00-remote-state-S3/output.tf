output "remote_state_bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "remote_state_arn" {
  value = aws_s3_bucket.terraform_state.arn
}