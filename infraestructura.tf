provider "aws" {
  region = var.aws_region
}

# Crear VPC
resource "aws_vpc" "infra_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Infra-VPC"
  }
}

# Crear Subred Pública
resource "aws_subnet" "infra_public_subnet" {
  vpc_id                  = aws_vpc.infra_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "Infra-Public-Subnet"
  }
}

# Crear Internet Gateway
resource "aws_internet_gateway" "infra_igw" {
  vpc_id = aws_vpc.infra_vpc.id
  tags = {
    Name = "Infra-Internet-Gateway"
  }
}

# Crear Tabla de Rutas Pública
resource "aws_route_table" "infra_public_route_table" {
  vpc_id = aws_vpc.infra_vpc.id
  tags = {
    Name = "Infra-Public-Route-Table"
  }
}

# Ruta hacia Internet en la tabla pública
resource "aws_route" "infra_internet_route" {
  route_table_id         = aws_route_table.infra_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.infra_igw.id
}

# Asociar Tabla Pública a Subred Pública
resource "aws_route_table_association" "infra_public_route_assoc" {
  subnet_id      = aws_subnet.infra_public_subnet.id
  route_table_id = aws_route_table.infra_public_route_table.id
}

# Crear Security Group
resource "aws_security_group" "infra_security_group" {
  name        = "infra-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.infra_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

# Crear Instancia EC2
resource "aws_instance" "infra_ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.infra_public_subnet.id
  vpc_security_group_ids = [aws_security_group.infra_security_group.id]
  key_name      = var.key_name

  tags = {
    Name = "Infra-EC2-Instance"
  }
}
