data "aws_ssm_parameter" "github_app_private_key_pem" {
  name = "${var.prefix}-github-app-private-key-pem"
  with_decryption = true # return raw string by secure string
}

data "aws_ssm_parameter" "webhook_secret" {
  name = "${var.prefix}-webhook-secret"
  with_decryption = true
}

data "aws_ssm_parameter" "github_app_id" {
  name = "${var.prefix}-github-app-id"
  with_decryption = false # not a secret string
}
