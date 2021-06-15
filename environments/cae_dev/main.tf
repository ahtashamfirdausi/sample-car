provider "aws" {
  region     = "eu-west-2"
}


terraform {
  backend "s3" {
    bucket      = "carriyo-terraform-state"
    key         = "terraform/poc-setup_cae_dev/state/terraform.tfstate"
    region      = "eu-west-2"
    dynamodb_table = "carriyo-terraform-state-locks"
    encrypt = true
  }
}

module "ec2_instance_setup" {
  source = "../../modules/ec2_instance"
  vpc_name = module.cae-dev-network.vpc_name
  depends_on = [module.cae-dev-network]
}