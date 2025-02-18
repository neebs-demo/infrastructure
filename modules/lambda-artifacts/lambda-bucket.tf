variable "s3_bucket_name" {
  type = string
  description = "version used for lambdas"
}

variable "object_prefix" {
  type = string
  default = "lambda-artifact/"
}

locals {
  object_mapping  = { for file in module.lambdas.files :
    file => "${var.object_prefix}${file}"
  }
}

# create s3
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name = "terraform state bucket"
  }

  depends_on = [
    module.lambdas
  ]
}

# block public access (likely already defaulted by aws?)
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.lambda_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# objects
resource "aws_s3_object" "lambda_files" {
  for_each = local.object_mapping # iterate over object
  bucket = aws_s3_bucket.lambda_bucket.id
  key = each.value
  source = each.key
}
