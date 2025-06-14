
output "alb_dns_name" {
  description = "DNS del Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_target_group_arn_vote" {
  description = "ARN del Target Group vote asociado al ALB"
  value       = module.alb.target_group_arn_vote

}
output "alb_target_group_arn_result" {
  description = "ARN del Target Group result asociado al ALB"
  value       = module.alb.target_group_arn_result

}

output "ecs_service_name_vote" {
  description = "Nombre del servicio ECS Fargate del modulo Vote"
  value       = module.ecs_vote.ecs_service_name
}

output "ecs_service_name_result" {
  description = "Nombre del servicio ECS Fargate del modulo Result"
  value       = module.ecs_result.ecs_service_name
}

output "ecs_service_name_worker" {
  description = "Nombre del servicio ECS Fargate del modulo Worker"
  value       = module.ecs_worker.ecs_service_name
}


#Se retorna un unico ID de cluster ECS, ya que todos los servicios comparten el mismo cluster
output "ecs_cluster_id" {
  description = "ID del cluster ECS"
  value       = module.ecs_vote.ecs_cluster_id
  #Se retorna un unico ID de cluster ECS, ya que todos los servicios comparten el mismo cluster

}

output "vpc_id" {
  description = "ID de la VPC usada"
  value       = module.network.vpc_id
}

output "subnet_ids" {
  description = "IDs de las subnets privadas usadas por ECS"
  value       = module.network.private_subnet_ids
}

output "ecr_vote_url" {
  value = module.ecr_vote.repository_url
}

output "ecr_result_url" {
  value = module.ecr_result.repository_url
}

output "ecr_worker_url" {
  value = module.ecr_worker.repository_url
}
