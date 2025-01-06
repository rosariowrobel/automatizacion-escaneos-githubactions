# Automatización de Escaneos de Seguridad con GitHub Actions y Snyk

Este proyecto implementa un **workflow de GitHub Actions** para realizar escaneos de seguridad automáticamente utilizando **Snyk**. Además, se aprovisiona infraestructura básica en AWS mediante **Terraform**.

## Requisitos

1. **Cuenta de AWS** con permisos para crear recursos (VPC, Subnets, EC2, etc.).
2. **Cuenta de Snyk** para obtener un token de autenticación.
3. **Terraform** instalado en tu máquina.

## Configuración

### 1. Clonar el repositorio


git clone https://github.com/rosariowrobel/automatizacion-escaneos-githubactions.git
cd automatizacion-escaneos-githubactions

### 2. Configurar los archivos de Terraform
infraestructura.tf: Define los recursos de AWS (VPC, subred, Internet Gateway, Security Group, EC2).
variables.tf: Contiene las variables para personalizar la infraestructura.
salidas.tf: Muestra información relevante, como la IP pública de la instancia EC2.
3. **Ejecutar Terraform
Inicializa y despliega la infraestructura en AWS:
terraform init
terraform plan
terraform apply
4. **Configurar Snyk en GitHub
Accede a Settings > Secrets and variables > Actions en este repositorio.
Agrega un secreto llamado SNYK_TOKEN con tu token de autenticación desde Snyk.
5. **Ejecutar el Workflow de GitHub Actions
El workflow se activa automáticamente al realizar un push o pull request en la rama main.

### Resultados
Los resultados del escaneo de Snyk se pueden visualizar en la pestaña Actions del repositorio.
El workflow analiza los archivos Terraform en busca de vulnerabilidades y malas prácticas.
### Recursos Creados
**VPC: Configuración de red principal con rango CIDR.
**Subred Pública: Asociada a una tabla de rutas pública.
**Internet Gateway: Proporciona acceso a Internet.
**Security Group: Configuración de reglas para tráfico SSH y HTTP.
**Instancia EC2: Servidor virtual con acceso SSH y tráfico HTTP permitido.
### Limpieza de Recursos
Para evitar costos innecesarios, elimina los recursos creados con:
terraform destroy

### Tecnologías Utilizadas
**Terraform: Infraestructura como Código (IaC).
**GitHub Actions: Automatización de CI/CD.
**Snyk: Escaneo de seguridad para infraestructura.
