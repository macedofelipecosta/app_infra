vpc_cidr_block  = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
azs             = ["us-east-1a", "us-east-1b"]

environment     = "dev"
app_port        = 80

vote_image_url  = "123456789012.dkr.ecr.us-east-1.amazonaws.com/vote:dev"
aws_region      = "us-east-1"




#Variables asignadas momentaneamente para pruebas
cluster_name          = "voting-cluster-dev"
container_name        = "vote-container"
task_family            = "voting-task-dev"



result_image_url       = "123456789012.dkr.ecr.us-east-1.amazonaws.com/result:dev"
worker_image_url       = "123456789012.dkr.ecr.us-east-1.amazonaws.com/worker:dev"

result_port            = 80
