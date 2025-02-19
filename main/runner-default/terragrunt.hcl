include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../modules/runner-default"
}

dependency "base" {
  config_path = "../base"
}

dependency "lambda_artifacts" {
  config_path = "../lambda-artifacts"
}

inputs = {
  prefix = include.root.locals.prefix
  aws_region = include.root.locals.region

  vpc_id = dependency.base.outputs.vpc.vpc_id
  vpc_private_subnets = dependency.base.outputs.vpc.private_subnets

  lambda_artifacts_bucket_name = dependency.lambda_artifacts.outputs.lambda_artifacts_bucket_name
  lambda_webhook_artifact_key = dependency.lambda_artifacts.outputs.lambda_object_key_mapping["webhook.zip"]
  lambda_runner_binaries_syncer_key = dependency.lambda_artifacts.outputs.lambda_object_key_mapping["runner-binaries-syncer.zip"]
  lambda_runners_key = dependency.lambda_artifacts.outputs.lambda_object_key_mapping["runners.zip"]
}
