resource "aws_s3_bucket" "test_bucket" {
  bucket        = "aws-s3-tfstate-test-1122334456"
  force_destroy = true
}
