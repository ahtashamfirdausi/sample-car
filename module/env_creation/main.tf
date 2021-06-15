resource "aws_vpc" "carriyo_vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "carriyo_vpc"
    }
  
}

resource "aws_subnet" "carriyo_subnet_ec2" {
    vpc_id     = aws_vpc.carriyo_vpc.id
    cidr_block = var.subnet_ec2_
    map_public_ip_on_launch = "true"
    availability_zone       = "eu-west-2a"
    tags ={
        Name = "carriyo_subnet_ec2"
    }
}



# AMAZON EC2

data "aws_ami" "amazon_linux2"{
    most_recent = true
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-2.0.20201126.0-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  owners = ["amazon"] # Canonical

    
}
resource "aws_key_pair" "ec2_key_pair" {
    key_name = "carriyo-ec2-admin"
    public_key ="ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAxJz+5/yH46GhrbdmX97ugmLFpFrXx/qQx8qmPnGp/4YKZgBft/DKJIc0btHBW09G1O8yxgLq/PDbxohPfhF3HuAzG6NTPJULNFmrFYP76ebPnf1i/K72yASCPfSAIdmCNrKV6KPBjQIAy35cPVK++7Gscn1T9YeT/phynJWDl3Kz3vnyHqKTIjYLo1XgcO4uEOVz75yF69KJUeEr5IsSDEP3SKFzt2vHrZwkiDXxrJ55FyYSmln4j8q6ms2FmHNEtg5lcb/ULZ8bxesoIyJtHzSXqcCc6dzfkFRKxPCmgHNp9cajmDtXHcMQxeh3asCut/lQAMaahOFiQQG8Jg5R4Q== rsa-key-20210615"
  
}
resource "aws_instance" "ec2_instance" {
    ami = data.aws_ami.amazon_linux2.vpc_id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.ec2_sg.id]
    subnet_id = aws_subnet.carriyo_subnet_ec2.id
    key_name = aws_key_pair.ec2_key_pair.key_name
  
  user_data = <<EOF
  #!/bin/bash
  sudo su
  yum update -y
  yum install docker -y
  service docker start

  EOF


    tags = {
        Name = "ec2_instance"
    }
  
}

resource "aws_internet_gateway" "carriyo_ig" {
    vpc_id = aws_vpc.carriyo_vpc.id
    tags = {
        Name = "carriyo_ig"
    }
  
}
resource "aws_eip" "carriyo_nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.carriyo_ig]
}

resource "aws_security_group" "ec2_sg" {
  name = "ec2_sg"
  vpc_id = aws_vpc.carriyo_vpc.id

  ingress {
    description = "SSH Access from outside"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
  ingress {
    description = "SSH Access from outside"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  ingress {
    description = "SSH Access from outside"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}