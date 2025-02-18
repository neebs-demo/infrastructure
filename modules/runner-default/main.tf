module "github-runner" {
  source  = "github-aws-runners/github-runner/aws"
  version = var.target_version

  aws_region = var.aws_region
  vpc_id     = var.vpc_id
  subnet_ids = var.vpc_private_subnets

  prefix = var.prefix

  github_app = {
    key_base64     = base64encode(data.github_app_private_key_pem)
    id             = data.github_app_id
    webhook_secret = data.webhook_secret
  }

  lambda_s3_bucket                  = var.lambda_artifacts_bucket_name
  webhook_lambda_zip                = var.lambda_artifacts["webhook.zip"]
  runner_binaries_syncer_lambda_zip = var.lambda_artifacts["runner-binaries-syncer.zip"]
  runners_lambda_zip                = var.lambda_artifacts["runners.zip"]
  enable_organization_runners = true

  # for creating spot instances
  create_service_linked_role_spot = true
}
