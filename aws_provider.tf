terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
# FOr Production 
provider "aws" {
  region = "us-east-1"
}

#For Dev
provider "aws" {
  alias  = "west"
  region = "us-west-1"
}
