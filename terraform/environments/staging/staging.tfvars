
aws_region      = "us-east-1"
project_name    = "infra-as-code-pipeline"
vpc_cidr        = "10.0.0.0/16"
container_port  = 80
desired_count   = 2
container_image = "nginx:stable"