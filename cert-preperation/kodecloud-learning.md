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
 

