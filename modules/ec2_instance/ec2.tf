data "aws_ami" "amazon_linux2" {
  most_recent = true

  filter {
    name   = "name"
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

resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.amazon_linux2.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id = data.aws_subnet.ec2_subnet.id
  iam_instance_profile =  aws_iam_instance_profile.codedeploy_ec2_instance_profile.name
  key_name = aws_key_pair.ec2_key_pair.key_name

  user_data = <<EOF
#!/bin/bash
sudo su
yum -y update
yum install docker -y
service docker start

EOF

  tags = {
    Name = "Codedeploy"
  }
}