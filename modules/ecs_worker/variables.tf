variable "cluster_name" {
  description = "Nombre del cluster ECS"
  type        = string
}

variable "task_family" {
  description = "Nombre lógico del task definition"
  type        = string
}

variable "cpu" {
  description = "Cantidad de CPU para la tarea (ej: 256)"
  type        = string
}

variable "memory" {
  description = "Cantidad de memoria (ej: 512)"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN del rol de ejecución ECS"
  type        = string
}

variable "task_role_arn" {
  description = "ARN del rol que usa la tarea"
  type        = string
}

variable "image" {
  description = "URL de la imagen en ECR"
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

variable "desired_count" {
  description = "Cantidad deseada de tareas"
  type        = number
  default     = 1
}

variable "security_group_ids" {
  description = "Lista de security groups"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Asignar IP pública a la tarea"
  type        = bool
  default     = true
}

variable "region" {
  description = "Región AWS para logs"
  type        = string
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}


variable "subnet_ids" {
  description = "Lista de IDs de subnets privadas"
  type        = list(string)
}
variable "listener_rule_depends_on" {
  description = "Dependencia explícita con el listener rule del ALB"
  type        = any
  default     = null
}

