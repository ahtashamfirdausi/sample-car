data "aws_vpc" "aws_workspace_vpc" {
  id = ""

  filter {
    name = "tag:Name"
    values = [var.vpc_name]
  }

}

data "aws_subnet" "ec2_subnet" {
  vpc_id = data.aws_vpc.aws_workspace_vpc.id
  availability_zone = "eu-west-2b"

  filter {
    name = "tag:subnet_type"
    values = ["cae-dev-public-subnet"]
  }

}

resource "aws_security_group" "ec2_sg" {
  name = "ec2_sg"
  vpc_id = data.aws_vpc.aws_workspace_vpc.id

  ingress {
    description = "SSH Access from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.aws_workspace_vpc.cidr_block]
  }

  //Comment this
  ingress {
    description = "SSH Access from outside"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  //Comment this
  ingress {
    description = "SSH Access from outside"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.vpc_name
  }

}