module "lambdas" {
  source = "./lambda-artifacts"

  target_version = var.lambda_target_version
  s3_bucket_name = var.lambda_s3_bucket_name
}

module "base" {
  source = "./base"
  aws_region = var.aws_region
  prefix = var.prefix
}

module "runner" {
  source = "./runner-ubuntu"
  aws_region = var.aws_region
  prefix = var.prefix

  vpc_id = module.base.vpc.vpc_id
  vpc_private_subnets = module.base.vpc.private_subnets

  lambda_artifacts_bucket_name = module.lambdas.lambda_artifacts_bucket_name
  lambda_webhook_artifact_key = module.lambdas.lambda_object_key_mapping["webhook.zip"]
  lambda_runner_binaries_syncer_key = module.lambdas.lambda_object_key_mapping["runner-binaries-syncer.zip"]
  lambda_runners_key = module.lambdas.lambda_object_key_mapping["runners.zip"]

  depends_on = [ module.lambdas, module.base ]
}
