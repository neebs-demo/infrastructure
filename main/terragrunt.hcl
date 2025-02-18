terraform {
  source = "../modules"
}

inputs {
  content = "foo"
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket         = "my-tofu-state"
    key            = "${path_relative_to_include()}/tofu.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}
EOF
}
