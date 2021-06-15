resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}


resource "aws_key_pair" "ec2_key_pair" {
  key_name = "ec2-admin"
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "pem_file" {
  content     = tls_private_key.this.private_key_pem
  filename = "${path.cwd}/private_key/ec2-admin.pem"
  file_permission = "0400"
}