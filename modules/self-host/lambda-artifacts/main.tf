variable "target_version" {
  type = string
  description = "version used for lambdas"
}

module "lambdas" {
  # github.com - https://developer.hashicorp.com/terraform/language/modules/sources#github
  # generic git - https://developer.hashicorp.com/terraform/language/modules/sources#generic-git-repository
  # with revisions - https://developer.hashicorp.com/terraform/language/modules/sources#selecting-a-revision
  # unable to use dyn variables in module sources - https://github.com/hashicorp/terraform/issues/30441#issuecomment-1024371002
  source = "git::https://github.com/github-aws-runners/terraform-aws-github-runner.git//modules/download-lambda?ref=v6.2.2"
  lambdas = [
    {
      name = "webhook"
      tag  = var.target_version
    },
    {
      name = "runners"
      tag  = var.target_version
    },
    {
      name = "runner-binaries-syncer"
      tag  = var.target_version
    }
  ]
}
