variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR para la VPC"
  default     = "10.1.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR para la Subred Pública"
  default     = "10.1.1.0/24"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI para la instancia EC2"
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 en us-east-1
}

variable "key_name" {
  description = "Nombre del Key Pair"
  default     = "infra-key-pair"
}

variable "allowed_ssh_cidr" {
  description = "CIDR permitido para acceso SSH"
  default     = "0.0.0.0/0"
}
