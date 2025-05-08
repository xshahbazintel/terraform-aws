variable "cidr_block" {
  type = string
  default = "10.16.0.0/16"
  description = "vpc cidr value"
}

variable "region" {
    type = string
    default = "us-east-1"
    description = "Default region for vpc creation"
  
}

