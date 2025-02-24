### lambda-artifacts module ###

variable "lambda_s3_bucket_name" {
  type = string
  description = "version used for lambdas"
}

variable "lambda_target_version" {
  type = string
  description = "version used for lambdas"
}

### base module ###

variable "prefix" {
  description = "Prefix used for resource naming."
  type        = string
}

variable "aws_region" {
  description = "AWS region to create the VPC, assuming zones `a` and `b` exists."
  type        = string
}
