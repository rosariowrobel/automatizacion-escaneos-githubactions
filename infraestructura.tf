provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "infra_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Infra-VPC"
  }
}

# Subred Pública
resource "aws_subnet" "infra_public_subnet" {
  vpc_id                  = aws_vpc.infra_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "Infra-Public-Subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "infra_igw" {
  vpc_id = aws_vpc.infra_vpc.id

  tags = {
    Name = "Infra-Internet-Gateway"
  }
}

# Tabla de Rutas
resource "aws_route_table" "infra_public_route_table" {
  vpc_id = aws_vpc.infra_vpc.id

  tags = {
    Name = "Infra-Public-Route-Table"
  }
}

# Ruta a Internet
resource "aws_route" "infra_public_route" {
  route_table_id         = aws_route_table.infra_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.infra_igw.id
}

# Asociación de Tabla de Rutas con la Subred
resource "aws_route_table_association" "infra_public_route_assoc" {
  subnet_id      = aws_subnet.infra_public_subnet.id
  route_table_id = aws_route_table.infra_public_route_table.id
}

# Security Group
resource "aws_security_group" "infra_security_group" {
  vpc_id      = aws_vpc.infra_vpc.id
  description = "Infra Security Group"
  name        = "Infra-Security-Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["3.95.163.132/32"] # Cambia por tu IP pública
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["3.95.163.132/32"] # Cambia por tu IP pública
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Infra-Security-Group"
  }
}

# Instancia EC2
resource "aws_instance" "infra_ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.infra_public_subnet.id
  vpc_security_group_ids = [aws_security_group.infra_security_group.id] # Cambiar security_group_ids por vpc_security_group_ids

  tags = {
    Name = "Infra-EC2-Instance"
  }
}
