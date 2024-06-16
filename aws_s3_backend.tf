terraform {
  backend "s3" {
    bucket                      = "terraformbackendgfhfk"
    key                         = "terraform.tfstate"
    region                      = "us-east-1"
    dynamodb_table              = "terraform-state-lock-dynamo"
    encrypt                     = true
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}