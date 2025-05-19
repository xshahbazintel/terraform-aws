variable "aws_region"  
{

}

variable "aws_az"  
{

}

if you dont provide any default, you will be prompted to provide inputs or you can pass those as cli arguments.
you can pass as many var as you want 

terraform apply -var "aws_region=us-east-1" -var "aws_az=us-east-1a"

you also can pass a filename for terraform apply command

if you dont pass any varfile it will look for default vars file 

default vars file should be named as terraform.tfvars or terraform.tfvars.json or *.auto.tfvars or *.auto.tfvars.json 

you also can pass custom tfvars file while execution 

terraform apply -var-file dev.tfvars

Resource attributes:

when you want to link creation of one resource to another we use resource attributes

eg:
resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id  #refering to vpc created above
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-west-2a"
}

Resource Dependencies:
when you want to create one resource only after creation of another resource its a dependency 

resource "local_file" "whale" {
  filename = "/root/whale"
  content = "whale"
  depends_on = [ local_file.krill ]
}

resource "local_file" "krill" {
  filename = "/root/krill"
  content = "krill"
}


local variables



You can mark output values as ephemeral in child modules to pass ephemeral values between modules while avoiding persisting those values to state or plan files. This is useful for managing credentials, tokens, or other temporary resources you do not want to store in Terraform state files.