output "log_group_name" {
  description = "Nombre del grupo de logs de CloudWatch"
  value       = aws_cloudwatch_log_group.service_logs.name
}

output "log_group_arn" {
  description = "ARN del grupo de logs de CloudWatch"
  value       = aws_cloudwatch_log_group.service_logs.arn
}

output "cpu_alarm_arn" {
  description = "ARN de la alarma de CPU"
  value       = aws_cloudwatch_metric_alarm.cpu_utilization.arn
}

output "memory_alarm_arn" {
  description = "ARN de la alarma de memoria"
  value       = aws_cloudwatch_metric_alarm.memory_utilization.arn
}