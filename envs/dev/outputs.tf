output "alb_target_group_arn" {
  description = "ARN del Target Group asociado al ALB"
  value       = module.alb.target_group_arn_vote
}

output "ecs_service_name" {
  description = "Nombre del servicio ECS Fargate"
  value       = module.ecs_fargate.ecs_service_name
}

output "ecs_cluster_id" {
  description = "ID del cluster ECS"
  value       = module.ecs_fargate.ecs_cluster_id
}

output "vpc_id" {
  description = "ID de la VPC usada"
  value       = module.network.vpc_id
}

output "subnet_ids" {
  description = "IDs de las subnets privadas usadas por ECS"
  value       = module.network.private_subnet_ids
}
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

