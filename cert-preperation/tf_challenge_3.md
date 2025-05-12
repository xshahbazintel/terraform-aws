resource "aws_instance" "citadel" {
ami = var.ami
instance_type = var.instance_type
key_name = aws_key_pair.citadel-key.key_name 
user_data = file("/root/terraform-challenges/project-citadel/install-nginx.sh")

}

variable "ami"{
default = "ami-06178cf087598769c"
}

variable "region"{
default = "eu-west-2"
}

variable "instance_type"{
default = "m5.large"
}




resource "aws_eip" "eip" {
  instance = aws_instance.citadel.id
  provisioner "local-exec" {
    command = "echo ${self.public_dns} >> /root/citadel_public_dns.txt"
  }

}

resource "aws_key_pair" "citadel-key" {
  key_name   = "citadel"
  public_key = file("/root/terraform-challenges/project-citadel/.ssh/ec2-connect-key.pub")
}