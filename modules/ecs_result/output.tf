output "task_definition_arn" {
  description = "ARN de la definición de tarea"
  value       = aws_ecs_task_definition.this.arn
}

output "ecs_service_name" {
  description = "Nombre del servicio ECS"
  value       = aws_ecs_service.this.name
}

output "ecs_service_id" {
  description = "value of the ECS service ID"
  value = aws_ecs_service.this.id
}
