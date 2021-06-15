variable "region" {
  description = "AWS Deployment region.."
  default     = "eu-west-2"
}
variable "vpc_cidr_block" {
  default = "10.10.0.0/16"
}
variable "subnet_cidr_block"{
    default = "10.10.0.0/24"
}