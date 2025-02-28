variable "aws_region" {}
variable "cidr_block" {}
variable "availability_zones" {}
variable "public_subnet_count" {}
variable "private_subnet_count" {}

provider "aws" {
  region = var.aws_region

}

terraform {
  backend "s3" {
    bucket       = "terraform-state-phineart-jenkins"
    key          = "phineart/development/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
  }
}

resource "aws_vpc" "phineart_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "phineart_vpc"
  }

}

module "phineart_module" {
  source               = "./modules"
  vpc_id               = aws_vpc.phineart_vpc.id
  vpc_cidr_block       = aws_vpc.phineart_vpc.cidr_block
  availability_zones   = var.availability_zones
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
}