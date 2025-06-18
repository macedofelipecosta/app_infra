# modules/autoscaling/variables.tf

variable "service_name" {
  description = "Nombre del servicio ECS a escalar"
  type        = string
}

variable "cluster_name" {
  description = "Nombre del cluster ECS"
  type        = string
}

variable "min_capacity" {
  description = "Número mínimo de tasks"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Número máximo de tasks"
  type        = number
  default     = 4
}

variable "target_value" {
  description = "Valor objetivo para la métrica de escalado (ej: 70 para CPU)"
  type        = number
}

variable "metric_type" {
  description = "Tipo de métrica predefinida para escalado"
  type        = string
  default     = "ECSServiceAverageCPUUtilization"
}

variable "scale_in_cooldown" {
  description = "Tiempo de espera antes de reducir capacidad (segundos)"
  type        = number
  default     = 300
}

variable "scale_out_cooldown" {
  description = "Tiempo de espera antes de aumentar capacidad (segundos)"
  type        = number
  default     = 180
}