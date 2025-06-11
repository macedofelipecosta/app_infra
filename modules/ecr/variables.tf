variable "repository_name" {
  description = "Nombre del repositorio de ECR"
  type        = string
}

variable "force_delete" {
  description = "Indica si se debe forzar la eliminación del repositorio"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Etiquetas para aplicar al repositorio"
  type        = map(string)
  default     = {}
}

