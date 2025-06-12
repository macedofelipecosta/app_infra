output "ecs_execution_role_arn" {
  description = "ARN del rol de ejecución ECS"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN del rol de la tarea ECS"
  value       = aws_iam_role.ecs_task_role.arn
}
