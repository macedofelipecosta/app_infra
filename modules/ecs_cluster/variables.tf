variable "cluster_name" {
  description = "Nombre del cluster ECS"
  type        = string
}

variable "environment" {
  description = "Ambiente (dev, test, prod)"
  type        = string
}
variable "task_family" {
  description = "Familia de la tarea ECS"
  type        = string
}