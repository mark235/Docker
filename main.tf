provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
}

module "ec2" {
  source = "./modules/ec2"

  ami_id         = var.ami_id
  instance_type  = var.instance_type
  subnet_id      = module.vpc.private_subnet_id
  vpc_id         = module.vpc.vpc_id
  key_name       = var.key_name
}
