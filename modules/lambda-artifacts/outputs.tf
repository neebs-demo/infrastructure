output "lambda_artifacts_bucket_name" {
  value = var.s3_bucket_name
}

output "lambda_object_key_mapping" {
  value = local.object_mapping
}
