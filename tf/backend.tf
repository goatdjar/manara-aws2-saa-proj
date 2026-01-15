terraform {
  backend "s3" {
    bucket  = "aws-s3-tfstate-test-1122334455"
    key     = "terraform/state"
    region  = "ap-southeast-1"
    encrypt = true
  }
}
