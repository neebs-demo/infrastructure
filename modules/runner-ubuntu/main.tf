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

  # enabling ubuntu 2204
  # runner config
  runner_os = "linux"
  runner_architecture = "x64"
  runner_run_as = "ubuntu"
  runner_name_prefix = "ubuntu-2204-x64_"

  userdata_template = "./templates/user-data.sh"

  # https://discourse.ubuntu.com/t/search-and-launch-ubuntu-22-04-in-aws-using-cli/27986
  ami_owners = ["099720109477"] # Canonical's Amazon account ID
  ami_filter = { # TF: map of list of string required
    name = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    state = ["available"]
  }

  # CW logging with {instance_id} is standard
  # https://docs.aws.amazon.com/prescriptive-guidance/latest/implementing-logging-monitoring-cloudwatch/configure-cloudwatch-ec2-on-premises.html#:~:text=The%20default%20log%20stream%20name,within%20the%20CloudWatch%20log%20group.
  runner_log_files = [
    {
      log_group_name = "syslog"
      prefix_log_group = true
      file_path = "/var/log/syslog"
      log_stream_name = "{instance_id}"
    },
    {
      log_group_name = "user_data"
      prefix_log_group = true
      file_path = "/var/log/user-data.log"
      log_stream_name = "{instance_id}/user_data"
    },
    {
      log_group_name = "runner"
      prefix_log_group = true
      file_path = "/opt/actions-runner/_diag/Runner_**.log"
      log_stream_name = "{instance_id}/runner"
    }
  ]
}

module "webhook_github_app" {
  source     = "git::https://github.com/github-aws-runners/terraform-aws-github-runner.git//modules/webhook-github-app?ref=v6.2.2"
  depends_on = [module.github_runner]

  github_app = {
    key_base64     = base64encode(data.aws_ssm_parameter.github_app_private_key_pem.value)
    id             = data.aws_ssm_parameter.github_app_id.value
    webhook_secret = data.aws_ssm_parameter.webhook_secret.value
  }
  webhook_endpoint = module.github_runner.webhook.endpoint
}
