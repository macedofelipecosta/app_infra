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
variable "environment" {}

variable "app_port" {
  description = "Puerto del contenedor para vote" 
  type        = number
}

variable "vote_image_url" {}
variable "result_image_url" {}
variable "result_port" {
  type = number
}
variable "worker_image_url" {}

variable "aws_region" {}


variable "cluster_name" {}
variable "task_family" {}
variable "container_name" {}

variable "execution_role_arn" {}
variable "task_role_arn" {}

variable "ecs_execution_role_arn" {}
variable "ecs_task_role_arn" {}
