resource "aws_s3_bucket" "terraform" {
  bucket   = "terraformbackendgfhfk"
  provider = aws.west


  # Enabled Terraform lifecycle meta arrugment to prevent someone deleted this S3 bucket 
  lifecycle {
    prevent_destroy = false
  }
}
# Enable versioning
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.terraform.id
  versioning_configuration {
    status = "Enabled"
  }
}

#resource "aws_kms_key" "mykey" {t
#description             = "This key is used to encrypt bucket objects"
#deletion_window_in_days = 10
#}

# enabled encryption
#resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
#bucket = aws_s3_bucket.terraform.id

#rule {
#apply_server_side_encryption_by_default {
#kms_master_key_id = aws_kms_key.mykey.arn
#sse_algorithm     = "aws:kms"
#}
#}
#}

# dynamodb is used to lock an statefile
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}
