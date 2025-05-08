terraform {
  backend "s3" {
    bucket = "bucketname" 
    key = "terraform-practice/terraform.tfstate"
    region = "us-east-1"

  }
}
