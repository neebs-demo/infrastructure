# create s3
resource "aws_s3_bucket" "backend_bucket" {
  bucket = "ci-test-terraform-state-bucket"

  tags = {
    Name = "terraform state bucket"
  }
}

# block public access (likely already defaulted by aws?)
resource "aws_s3_bucket_public_access_block" "block_public_acces" {
  bucket = aws_s3_bucket.backend_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# enable versioning (need for manual config)
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.backend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# enable enc (default enc - sse-s3)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.backend_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

# create ddb
resource "aws_dynamodb_table" "example" {
  name = "terraform_state"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# uncomment out when ddb and s3 are created
# terraform {
#   backend "s3" {
#     bucket         = "ci-test-terraform-state-bucket"
#     key            = "app/app.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform_state"
#   }
# }
