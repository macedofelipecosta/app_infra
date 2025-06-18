output "ecs_service_name" {
  description = "Nombre del servicio ECS Redis"
  value       = aws_ecs_service.redis.name
}

output "task_definition_arn" {
  description = "ARN de la definición de tarea Redis"
  value       = aws_ecs_task_definition.redis.arn
}
