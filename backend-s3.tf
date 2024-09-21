terraform {
  backend "s3" {
    bucket = "terraform-sync"
    key    = "terraform/backend-aws"
    region = "eu-west-2"
  }
}