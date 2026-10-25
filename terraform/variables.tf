
variable "aws_region" {
  description = "AWS region where infrastructure will be created"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the DevOps capstone project"
  type        = string
  default     = "infra-as-code-pipeline"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}