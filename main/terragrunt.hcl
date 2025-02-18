terraform {
  source = "../modules"
}

locals {
  backend_s3 = "ci-test-terraform-state-bucket"
  backend_ddb = "terraform-state-table"
  region = "us-east-1"
}

inputs = {
  backend_s3 = local.backend_s3
  backend_ddb = local.backend_ddb
}

# TODO: Place generate blocks in a root.hcl file

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# credentials will be from provided AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN
provider "aws" {
  region = "${local.region}"
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket         = "${local.backend_s3}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.region}"
    encrypt        = true
    dynamodb_table = "${local.backend_ddb}"
  }
}
EOF
}
