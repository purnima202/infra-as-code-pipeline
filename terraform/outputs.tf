
output "vpc_id" {
  description = "VPC ID created by the networking module"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.networking.public_subnet_ids
}

output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = module.security.alb_security_group_id
}

output "ecs_security_group_id" {
  description = "ECS security group ID"
  value       = module.security.ecs_security_group_id
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.compute.ecr_repository_url
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = module.compute.ecs_cluster_name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = module.compute.ecs_service_name
}

output "load_balancer_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = module.compute.load_balancer_dns_name
}

output "ecs_cpu_alarm_name" {
  description = "CloudWatch ECS CPU alarm name"
  value       = module.monitoring.ecs_cpu_alarm_name
}