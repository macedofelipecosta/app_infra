output "cluster_id" {
  description = "ARN del ECS Cluster"
  value       = aws_ecs_cluster.this.arn
}
output "cluster_name" {
  description = "Nombre del ECS Cluster"
  value       = aws_ecs_cluster.this.name
}