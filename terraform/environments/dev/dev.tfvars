
aws_region      = "us-east-1"
project_name    = "infra-as-code-pipeline"
vpc_cidr        = "10.0.0.0/16"
container_port  = 80
desired_count   = 2
container_image = "989615776596.dkr.ecr.us-east-1.amazonaws.com/infra-as-code-pipeline:98a2a3f50d13a7c1e38b81f49c6402edc69699e5"