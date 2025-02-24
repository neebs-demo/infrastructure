output "runners" {
  value = module.runner.runners.lambda_syncer_name
}

output "webhook_endpoint" {
  value = module.runner.webhook_endpoint
}

output "webhook_secret" {
  sensitive = true
  value     = module.runner.webhook_secret
}

output "lambda_artifacts_bucket_name" {
  value = module.lambdas.lambda_artifacts_bucket_name
}

output "lambda_webhook_artifact_key" {
  value = module.lambdas.lambda_object_key_mapping["webhook.zip"]
}

output "lambda_runner_binaries_syncer_key" {
  value = module.lambdas.lambda_object_key_mapping["runner-binaries-syncer.zip"]
}

output "lambda_runners_key" {
  value = module.lambdas.lambda_object_key_mapping["runners.zip"]
}
