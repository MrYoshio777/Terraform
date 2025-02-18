# Proyecto de Creación de Recursos en Azure con Terraform
Este repositorio contiene un proyecto de Infraestructura como Código (IaC) utilizando Terraform para la creación y configuración de varios recursos de Azure, incluyendo un ejemplo de Azure SQL Database. La finalidad de este proyecto es ilustrar cómo automatizar y gestionar de forma declarativa la infraestructura en la nube.

# ¿Qué es Terraform?
Terraform es una herramienta de IaC (Infrastructure as Code) de código abierto desarrollada por HashiCorp. Permite describir la infraestructura en archivos de configuración de texto plano (normalmente con extensión .tf), y con esos archivos se pueden crear, modificar y eliminar recursos en diferentes proveedores de nube de manera automatizada.

# Contenido del repositorio
- Archivos de configuración de Terraform

- main.tf: Define los recursos principales, incluyendo la creación del grupo de recursos de Azure y la base de datos SQL.
- variables.tf: Contiene la definición de variables como nombres de recursos, ubicaciones, credenciales, etc.
- outputs.tf: Muestra la información de salida relevante (por ejemplo, la cadena de conexión de la base de datos).
- providers.tf (o incluido dentro de main.tf): Configura el proveedor de Azure junto con la información de autenticación necesaria.

# Ejemplo de implementación de una Azure SQL Database

1. Creación de un Resource Group (Grupo de recursos) en Azure.
2. Despliegue de un Azure SQL Server.
3. Configuración de una Azure SQL Database.
4. Opcionalmente, configuración de un Firewall Rule para permitir el acceso desde direcciones IP específicas.
5. 
# Scripts o instrucciones adicionales
Puede haber scripts de PowerShell, Bash o archivos .sh con ejemplos de comandos para inicializar, planificar y desplegar la infraestructura.
Requisitos Previos
Suscripción de Azure

Se requiere una cuenta de Azure activa. Si aún no tienes una, puedes crear una cuenta gratuita aquí.
Herramientas Instaladas

Terraform: Descarga la versión estable desde la página oficial de Terraform.
Azure CLI (opcional, pero recomendado): Puedes instalarlo siguiendo las instrucciones de Microsoft.
Acceso y Autenticación

Asegúrate de haber iniciado sesión en Azure (con az login) o de configurar tus credenciales de forma segura (por ejemplo, mediante variables de entorno o un Service Principal).
