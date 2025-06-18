# modules/autoscaling/outputs.tf

output "scaling_target_arn" {
  description = "ARN del target de autoscaling"
  value       = aws_appautoscaling_target.target.resource_id
}

output "scaling_policy_arn" {
  description = "ARN de la política de escalado"
  value       = aws_appautoscaling_policy.scaling_policy.arn
}