variable "aws_region" {
  type = string
  description = "aws region"
}

variable "vpc_id" {
  type = string
  description = "vpc id"
}

variable "vpc_private_subnets" {
  type = list(string)
  description = "vpc private subnets"
}

variable "prefix" {
  type = string
  description = "resource prefix"
}

variable "lambda_artifacts_bucket_name" {
  type = string
  description = "bucket name where lambda artifacts are stored"
}

variable "lambda_webhook_artifact_key" {
  type = string
}

variable "lambda_runner_binaries_syncer_key" {
  type = string
}

variable "lambda_runners_key" {
  type = string
}
