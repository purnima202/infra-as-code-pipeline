
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

variable "vpc_cidr" {
  description = "CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "container_port" {
  description = "Port on which the application container listens"
  type        = number
  default     = 80
}

variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 2
}

variable "container_image" {
  description = "Docker image to deploy"
  type        = string
  default     = "nginx:stable"
}