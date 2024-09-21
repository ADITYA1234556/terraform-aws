module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  #source = "terraform-aws-modules/vpc/aws" -this terraform-aws-modules/vpc/aws will get generated only after modules are downloaded after terraform init command
  name            = var.VPC_NAME
  cidr            = var.VPC-CIDR
  azs             = [var.ZONE1, var.ZONE2, var.ZONE3]
  public_subnets  = [var.PUBSUB1CIDR, var.PUBSUB2CIDR, var.PUBSUB3CIDR]
  private_subnets = [var.PVTSUB1CIDR, var.PVTSUB2CIDR, var.PVTSUB3CIDR]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "True"
    Environment = "Prod"
  }

  vpc_tags = {
    Name = var.VPC_NAME
  }

}