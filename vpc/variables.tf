variable "region" {
  description = "Region you want to create resources"
  default = "us-east-1"
}

variable "cidr_block" {
    description = "CIDR block for vpc"
    default = "10.2.0.0/16"
  
}