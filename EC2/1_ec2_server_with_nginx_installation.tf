provider "aws" {
  region = "us-east-1"
}

#create vpc
resource "aws_vpc" "vpc" {
  cidr_block = "10.20.0.0/16"
  tags = {
    Name = "nginx-terraform-vpc"
  }
}

#create subnet
resource "aws_subnet" "nginx-web-subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.20.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "nginx-web-subnet1-terraform-vpc"
  }
  
}

#create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "nginx-terraform-igw"
  }
}

# resource "aws_internet_gateway_attachment" "igw-attachment-vpc" {
#   internet_gateway_id = aws_internet_gateway.igw.id
#   vpc_id              = aws_vpc.vpc.id
# }

#create route table
resource "aws_route_table" "nginx_route_table" {
  vpc_id = aws_vpc.vpc.id  # Reference to your VPC

  route {
    cidr_block = "0.0.0.0/0"  # Route all traffic to the Internet
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.nginx-web-subnet1.id
  route_table_id = aws_route_table.nginx_route_table.id
}

resource "aws_security_group" "nginx-terraform" {
  name        = "Allow 22 and 80"
  description = "Allow TCP 80 and ssh 22"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "nginx-terraform-sg"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere
  }
ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere (you can narrow this down for security)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "server" {
  ami                     = "ami-0ac4dfaf1c5c0cce9"
  instance_type           = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.nginx-terraform.id ]
  subnet_id = aws_subnet.nginx-web-subnet1.id
  key_name        = "shahbaz-laptop-key-pair-us-east-1"

  connection {
    host = self.public_ip
    type = "ssh"
    user = "ec2-user"
    private_key = file("C:/Users/shaik/Downloads/shahbaz-laptop-key-pair-us-east-1.pem")
  }

    provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx"
    ]
  }

}