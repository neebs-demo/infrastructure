# Recommended pattern: https://terragrunt.gruntwork.io/docs/migrate/migrating-from-root-terragrunt-hcl/
# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#include
include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../modules/state-backend"
}

inputs = {
  backend_s3 = include.root.locals.backend_s3
  backend_ddb = include.root.locals.backend_ddb
}
