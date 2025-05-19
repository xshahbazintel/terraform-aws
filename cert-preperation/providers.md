version constraints:
when you want terraform to use a particular provider we use version constraints

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 1.0.4"
    }
  }
}

#if you want to configure any extra details to provider

terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "/root/.kube/config"
}



Aliases:

when you want to create resources in multiple regions for same provider we use aliases

provider "aws" {

  region = "us-east-1"
  alias = "east"
}


provider "aws" {

  region = "us-west-1"
  alias = "west"
}


to use this  in resource block 

resource "aws_instance" "web" {

  #provider= <provider>.<alias>
  provider= aws.west
}