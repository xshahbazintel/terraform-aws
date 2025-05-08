provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "aws_s3_bucket" {
  bucket = var.aws_s3_bucket
}