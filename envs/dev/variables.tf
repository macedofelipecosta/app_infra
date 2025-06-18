#Configuracion de variables para el entorno de desarrollo
variable "environment" {}
variable "aws_region" {}


#Variables para el modulo Network
variable "vpc_cidr_block" {}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}

#Variables para el modulo Security Groups
variable "app_port" {
  description = "Puerto del contenedor para vote" 
  type        = number
}


#Imagenes de contenedor
variable "vote_image_url" {}
variable "result_image_url" {}
# variable "result_port" {
#   type = number
# }
variable "worker_image_url" {}



#Variables para el Cluster ECS
variable "cluster_name" {}
# variable "task_family" {}
# variable "container_name" {}

# variable "execution_role_arn" {}
# variable "task_role_arn" {}

# variable "ecs_execution_role_arn" {}
# variable "ecs_task_role_arn" {}
