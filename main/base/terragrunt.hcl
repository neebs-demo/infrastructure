include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../modules/base"
}

inputs = {
  prefix = include.root.locals.prefix
  aws_region = include.root.locals.region
}
