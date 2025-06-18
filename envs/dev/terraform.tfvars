#Configuracion de variables para el entorno de desarrollo
environment = "dev"
aws_region = "us-east-1"

#Variables para el modulo Network
vpc_cidr_block  = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
azs             = ["us-east-1a", "us-east-1b"]


#Variables para el modulo Security Groups
app_port    = 80

#Variables para el Cluster ECS
cluster_name   = "votingApp-cluster-dev"

#Imagenes de contenedor
result_image_url = "233749785955.dkr.ecr.us-east-1.amazonaws.com/result:latest"
vote_image_url   = "233749785955.dkr.ecr.us-east-1.amazonaws.com/vote:latest"
worker_image_url = "233749785955.dkr.ecr.us-east-1.amazonaws.com/worker:latest"


