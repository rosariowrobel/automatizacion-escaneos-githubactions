# Región donde se despliega la infraestructura
variable "region" {
  description = "Región de AWS para desplegar los recursos"
  default     = "us-east-1"
}

# CIDR de la VPC
variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  default     = "10.0.0.0/16"
}

# CIDR de la Subred Pública
variable "public_subnet_cidr" {
  description = "CIDR block para la Subred Pública"
  default     = "10.0.1.0/24"
}

# Tipo de instancia EC2
variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}

# AMI ID para la instancia EC2
variable "ami_id" {
  description = "AMI ID para la instancia EC2"
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 en us-east-1
}

# Nombre del Key Pair para acceder a la instancia EC2
variable "key_name" {
  description = "Nombre del Key Pair para SSH"
  default     = "infra-key-pair" # Cambia si tu Key Pair tiene otro nombre
}
