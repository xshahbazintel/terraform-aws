statefile is a blueprint of all the resources that terraform manages in realworld
when terraform creates a resource it records it in terraform.tf state file


list 
mv 
pull
rm 
show

terraform state list #list all resources creates in provider.resource_name format
example:
local_file.sample
aws_ec2.webserver

terraform state:
terraform state show aws_s3_bucket.shahbaz_123 #shahbaz_123 is resource name in terraform 
this will print all the details if shahbaz_123 resource like bucket name , arn and ...



terraform state mv is a powerfull command
if there are two tf state files managed for 2 different teams, now if you want to move one resource to managed for another command 

before resource name is ultra_pet, now you want to change this my_pet but you dont want to terraform to create new one

resource "random_pet" "ultra_pet" {
    length = var.length1
    prefix = var.prefix1
}

1. terraform state mv random_pet.ultra_pet random_pet.my_pet

2. change in main.tf to 

resource "random_pet" "my_pet" {
    length = var.length1
    prefix = var.prefix1
}


We no longer wish to manage the file located at /root/anime/hall-of-fame.txt by Terraform. Remove the resource responsible for this file completely from the management of terraform.
this is how resource block in main.tf looks like

resource "local_file" "hall_of_fame" {
  filename = "/root/anime/hall-of-fame.txt"
  content = "1.Attack On Titan\n2. Naruto\n3. Bleach\n"

}

run
terraform state rm local_file.hall_of_fame
and remove corresponding resource block in main.tf