include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/lambda-artifacts"
}

# NOTE:
# .this only has to be run once (on bootstrap)
# .update the locals version && the module source version!
# .get the latest version from here: https://github.com/github-aws-runners/terraform-aws-github-runner

inputs = {
  # WARNING: go to main.tf of module and also update the module source version!
  target_version = "v6.2.2"
  s3_bucket_name = "ci-test-lambda-artifacts"
}

# output
# lambda_object_key_mapping = {
#   "runner-binaries-syncer.zip" = "lambda-artifact/runner-binaries-syncer.zip"
#   "runners.zip" = "lambda-artifact/runners.zip"
#   "webhook.zip" = "lambda-artifact/webhook.zip"
# }
