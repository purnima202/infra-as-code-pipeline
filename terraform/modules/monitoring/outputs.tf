
output "ecs_cpu_alarm_name" {
  description = "Name of the ECS CPU utilization alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_cpu_high.alarm_name
}

output "ecs_cpu_alarm_arn" {
  description = "ARN of the ECS CPU utilization alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_cpu_high.arn
}