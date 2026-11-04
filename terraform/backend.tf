
terraform {
  backend "s3" {
    bucket         = "infra-as-code-pipeline-tfstate-2026-purnima"
    key            = "infra-as-code-pipeline/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
    use_lockfile   = true
  }
}