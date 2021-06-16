provider "aws" {
  region     = "eu-west-2"
}
terraform{
resource "aws s3 bucket" "carriyo" {
  bucket = "carriyo-terraform-states"
  key = "terraform/poc-carriyo/state/terraform.state"
  region ="eu-west-2"
  encrypt = true
  }
}


module "env_creation" {
  source = "../../module/env_creation"
  region = var.region
  vpc_cidr_block = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  
  
}