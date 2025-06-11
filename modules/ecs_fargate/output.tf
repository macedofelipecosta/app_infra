output "ecs_cluster_id" {
  description = "ID del cluster ECS"
  value       = aws_ecs_cluster.this.id
}

output "ecs_service_name" {
  description = "Nombre del servicio ECS"
  value = aws_ecs_service.this.name
}

output "task_definition_arn" {
  description = "ARN de la definición de tarea"
  value       = aws_ecs_task_definition.this.arn
}

output "service_arn" {
  description = "ARN del servicio ECS"
  value       = aws_ecs_service.this.arn
}
