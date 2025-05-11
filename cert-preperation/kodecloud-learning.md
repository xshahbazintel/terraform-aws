providers: providers are terraform plugins that connects to the cloud using api and helps in deploying infrastructure.
terraform also used to manage network devices, monitoring platforms, databases.

Terraform works in 3 phases
init: initlizes the project, identifies providers that are needed to create infrastructure
plan:  plans the infra without actually creating it, this is like a dryrun
apply: apply the infra mentioned in code to target cloud or any platform

resource "local_file" "textfile"{
    content="Hello world"
    filename = "root/hello.txt"
}

local is provider file is the plugin or resource it will create textfile is logical name, this can be anything, block you should provide parameters that local_file needs
 

terraform taint:
when you create a resource, suppose an ec2 instance, after the instance is created you are storing some of the info in local path using local provisioner and if the file path is incorrect, the instance is created but still terraform will mark it as taint meaning failed to create, when you apply once again it will try to create once again

terraform tain aws_ec2.webserver 
terraform untaint aws_ec2.webserver

export TF_LOG_PATH = <path_to_store_terraform_logs>
export TF_LOG = <log-level>


Terraform Import:
terraform import aws_instance.<resource-name> <unique-identifier_of_resource>