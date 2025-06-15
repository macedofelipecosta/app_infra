variable "cluster_name" {
  description = "Nombre del ECS Cluster"
  type        = string
}

variable "cluster_id" {
  description = "ID del ECS Cluster existente"
  type        = string
}


variable "task_family" {
  description = "Nombre de la familia de tareas ECS"
  type        = string
}

variable "container_name" {
  description = "Nombre del contenedor"
  type        = string
}

variable "container_port" {
  description = "Puerto del contenedor"
  type        = number
}

variable "image" {
  description = "URL de la imagen del contenedor"
  type        = string
}

variable "cpu" {
  description = "Cantidad de CPU para la tarea"
  type        = string
}

variable "memory" {
  description = "Memoria asignada para la tarea"
  type        = string
}

variable "desired_count" {
  description = "Cantidad de instancias deseadas"
  type        = number
}

variable "subnet_ids" {
  description = "Subredes privadas para Fargate"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Lista de Security Groups para el servicio ECS"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Asignar IP pública al servicio"
  type        = bool
}

variable "region" {
  description = "Región AWS"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN del rol de ejecución ECS"
  type        = string
}

variable "task_role_arn" {
  description = "ARN del rol de tareas ECS"
  type        = string
}

variable "target_group_arn" {
  description = "(Opcional) ARN del target group para el balanceador"
  type        = string
  default     = null
}

variable "listener_rule_depends_on" {
  description = "(Opcional) Recurso del listener rule para forzar dependencia"
  type        = any
  default     = null
}

variable "tags" {
  description = "Tags comunes"
  type        = map(string)
}
