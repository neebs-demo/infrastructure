variable "backend_s3" {
  type = string
  description = "state backend s3 bucket name"
}

variable "backend_ddb" {
  type = string
  description = "state backend dynamo db table name"
}
