resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.azs[count.index]
  tags = {
    Name        = "${var.environment}-public-subnet-${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name        = "${var.environment}-private-subnet-${count.index + 1}"
    Environment = var.environment
  }
}


# NAT Gateway en cada AZ
resource "aws_nat_gateway" "nat" {
  count         = length(var.public_subnets)
  allocation_id = aws_eip.eip_nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name = "${var.environment}-nat-gw-${count.index}"
  }
  depends_on = [aws_internet_gateway.igw]
}

#La version anterior asigna un NATGateway por cada subred publica, pero utiliza una sola EIP para ambos NAT Gateways.
# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public[0].id
#   depends_on    = [aws_internet_gateway.igw]
#   tags = {
#     Name        = "${var.environment}-nat-gateway"
#     Environment = var.environment
#   }
# }

#Crea IP Elasticas para cada NAT Gateway
resource "aws_eip" "eip_nat" {
  count = length(var.public_subnets)
  domain = "vpc"
  tags = {
    Name = "${var.environment}-nat-eip-${count.index}"
  }
}
#Aui debajo esta la version anterior, utiliza unicamente una eip para ambos NAT Gateways. Descomentar si se desea utilizar una sola EIP
# resource "aws_eip" "nat" {
#   domain = "vpc"
#   tags = {
#     Name        = "${var.environment}-nat-eip"
#     Environment = var.environment
#   }
# }

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.environment}-public-rt"
    Environment = var.environment
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


#Route table para subredes privadas
resource "aws_route_table" "private" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.environment}-private-rt"
    Environment = var.environment
  }
}

#Ruta para acceso a internet desde las subredes privadas a traves del NAT Gateway
resource "aws_route" "private_nat_access" {
  count = length(var.public_subnets)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat[0].id
}

#Asocia las subredes privadas a las tablas de ruteo privadas para que puedan acceder a internet a traves del NAT Gateway
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
