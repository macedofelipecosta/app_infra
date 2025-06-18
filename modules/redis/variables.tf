variable "cluster_id" {
  description = "ID del ECS Cluster"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN del rol de ejecución ECS"
  type        = string
}

variable "task_role_arn" {
  description = "ARN del rol de tarea ECS"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets privadas donde se desplegará Redis"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups que permiten acceso a Redis"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Indica si se asigna IP pública"
  type        = bool
  default     = false
}

variable "cpu" {
  description = "CPU de la tarea Redis"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Memoria de la tarea Redis"
  type        = string
  default     = "512"
}

variable "redis_port" {
  description = "Puerto en el que Redis escucha"
  type        = number
  default     = 6379
}

variable "tags" {
  description = "Etiquetas comunes"
  type        = map(string)
  default     = {}
}
