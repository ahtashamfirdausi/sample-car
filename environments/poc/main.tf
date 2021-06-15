provider "aws" {
  region     = "eu-west-2"
}
terraform {
  backend "s3" {
    bucket      = "carriyo-terraform-states"
    key         = "terraform/poc-carriyo/state/terraform.tfstate"
    region      = "eu-west-2"
   dynamodb_table = "carriyo-terraform-state-locks"
    encrypt = true
  }
}
module "env_creation" {
  source = "../../module/env_creation"
  region = var.region
  vpc_cidr_block = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  
  
}