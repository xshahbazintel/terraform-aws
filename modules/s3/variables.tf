variable "aws_s3_bucket" {
  type = string
  default = "shahbaz-s3-terraform"
  description = "S3 bucket name, should be unique across all aws accounts"
}

variable "region" {
  type = string
  default = "us-east-1"
  description = "S3 bucket region"
}