module "github_runner" {
  source  = "github-aws-runners/github-runner/aws"
  # On bootstrap, ensure same version as lambda-artifacts
  # On update, OK to bump version
  version = "6.2.2"

  aws_region = var.aws_region
  vpc_id     = var.vpc_id
  subnet_ids = var.vpc_private_subnets

  prefix = var.prefix

  github_app = {
    key_base64     = base64encode(data.aws_ssm_parameter.github_app_private_key_pem.value)
    id             = data.aws_ssm_parameter.github_app_id.value
    webhook_secret = data.aws_ssm_parameter.webhook_secret.value
  }

  lambda_s3_bucket                  = var.lambda_artifacts_bucket_name
  webhook_lambda_s3_key             = var.lambda_webhook_artifact_key
  syncer_lambda_s3_key              = var.lambda_runner_binaries_syncer_key
  runners_lambda_s3_key             = var.lambda_runners_key
  enable_organization_runners = true

  # for creating spot instances
  create_service_linked_role_spot = true

  # -1 to use account's unreserved concurrency
  # .Will result in error due to new acc Concurrency Quota
  # .https://github.com/github-aws-runners/terraform-aws-github-runner/pull/1415
  scale_up_reserved_concurrent_executions = -1

  # enable connection to runners
  enable_ssm_on_runners = true
}
