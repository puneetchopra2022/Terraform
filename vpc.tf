data "aws_availability_zones" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"
 
  name = "var.vpcname"
  cidr = "var.cidr"

  azs             = data.aws_availability_zones.available.names
  private_subnets = ["var.private[0]", "var.private[1]", "var.private[2]"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Terraform = "true"
    Environment = "dev"
    Clustername = "var.vpcname"
  }
}

