provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc_terraform" {
  cidr_block = var.cidr_block
  tags = {Name="terraform-vpc"}

}