output "runners" {
  value = {
    lambda_syncer_name = module.github_runner.binaries_syncer.lambda.function_name
  }
}

output "webhook_endpoint" {
  value = module.github_runner.webhook.endpoint
}

output "webhook_secret" {
  sensitive = true
  value     = data.aws_ssm_parameter.webhook_secret.value
}

output "lambda_artifacts_bucket_name" {
  value = var.lambda_artifacts_bucket_name
}

output "lambda_webhook_artifact_key" {
  value = var.lambda_webhook_artifact_key
}

output "lambda_runner_binaries_syncer_key" {
  value = var.lambda_runner_binaries_syncer_key
}

output "lambda_runners_key" {
  value = var.lambda_runners_key
}
