variable "unit" {
  description = "the name of your unit"
  default     = "cae-dev"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "20.0.0.0/16"
}

variable "private_subnets" {
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["20.0.16.0/20","20.0.32.0/20"]
}

variable "public_subnets" {
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["20.0.48.0/20","20.0.64.0/20"]
}






