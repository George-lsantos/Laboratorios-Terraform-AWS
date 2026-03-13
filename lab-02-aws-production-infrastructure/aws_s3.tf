resource "aws_s3_bucket" "aws_s3" {
  bucket = "my-tf-test-aasdc"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}