terraform validate #to validate our resource files
terraform fmt
terraform show  #shows terraform statefile with created resources
terraform show -json #prints statefile output in json format
terrafom providers #shows all providers installed 
terraform providers mirror /root/new/path #mirrors proivders to /root/new/path

if any resources managed by terraform are changed in realworld manually and you want those changes into your statefile use

terraform plan
terraform apply --refresh-only #this will update your statefile if anychanges are made to the infra managed by terraform, by someone manually

terraform graph #this will visualize the infra created by terraform 
to use this 
install graphviz on linux machine
apt update
apt install graphviz -y 

terraform graph | dot -Tsvg >graph.svg



terraform taint
terraform untaint

terraform import 