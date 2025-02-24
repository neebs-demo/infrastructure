output "lambda_artifacts_bucket_name" {
  value = var.s3_bucket_name
}

output "lambda_object_key_mapping" {
  value = local.object_mapping
}

# output
# lambda_object_key_mapping = {
#   "runner-binaries-syncer.zip" = "lambda-artifact/runner-binaries-syncer.zip"
#   "runners.zip" = "lambda-artifact/runners.zip"
#   "webhook.zip" = "lambda-artifact/webhook.zip"
# }
