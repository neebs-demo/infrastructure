include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "base" {
  config_path = "../base"
}

dependency "lambda_artifacts" {
  config_path = "../lambda-artifacts"
}

inputs = {
  prefix = include.root.local.prefix
  aws_region = include.root.local.aws_region

  vpc_id = dependency.base.vpc.vpc_id
  vpc_private_subnets = dependency.base.vpc.private_subnets

  lambda_artifacts_bucket_name = dependency.lambda_artifacts.lambda_artifacts_bucket_name
  lambda_artifacts = dependency.lambda_object_key_mapping
}
