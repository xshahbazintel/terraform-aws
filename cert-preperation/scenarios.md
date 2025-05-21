1. I have created some resources in aws using terraform, someone else did changes to one resource manually in UI, how can i bring changes to my tfstate file 
This is called drift detection, if you just want to update statefile do 
terraform refresh
on which resource changes were applied, update the resource block with changes made in UI
now run terraform plan, this should show now changes to apply 

2. what does terraform plan do?

By default, Terraform performs the following operations when it creates a plan:

Reads the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date.
Compares the current configuration to the prior state and noting any differences.
Proposes a set of change actions that should, if applied, make the remote objects match the configuration.

3. There are some resources created in cloud manually, they are not managed by terraform, i want to manage them using terraform, how can we do it?

use terraform import command 
create a resource block, with corresponding resource you want to manage

eg: if you want to manage a instance in aws 

create a resource block like this 

resource "aws_ec2_instance" "webserver_in_ui"{

}

do terraform import

terraform import aws_ec2_instance.webserver_in_ui <instance.id>

this will update statefile with that resource

now complete the resource aws_ec2_instance.webserver with details required 

run terraform plan and check, this should not plan to create resource


4. How can we version modules?
   we can version modules using git and do a version tagging and refer source to that github repository and version
   we can use s3 bucket, create a s3 bucket terraform-modules-bucket/vpc-module/v1.0.0/module.zip 
   refer that using 
   module "s3_module"{
    source="s3::<module-path>"
    source="s3::https://s3.amazonaws.com/terraform-modules-bucket/vpc-module/v1.0.0/module.zip "
    }

5. How did you manage secrets in terraform?
   you can input in cli when apply 
   store in tfvars file and dont commit those to github repo add in .gitignore 
   export values as terraform environment variables like this 
   TF_MYSQL_PASSWORD = ""
   you can use vault services like terraform vault to fetch data
   for this you have to make use of data block 
           or 
    you can use cloud services like aws ssm create secrets and refer using data blocks in terraform



