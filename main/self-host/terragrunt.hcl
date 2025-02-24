include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../modules/self-host"
}

inputs = {
  # general inputs
  prefix = include.root.locals.prefix
  aws_region = include.root.locals.region

  # for lambdas
  lambda_target_version = "v6.2.2"
  lambda_s3_bucket_name = "${include.root.locals.prefix}-lambda-artifacts"

  # for base infrastructure (vpc, NAT, etc.)
  # no addn input apart from general inputs

  # self-host infrastructure
  # no addn input apart from general inputs
}
