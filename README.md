# generic_terraform

Repositorio de Infraestructura como Código (IaC) desarrollado con Terraform para la gestión de infraestructura en AWS. Este proyecto forma parte de mi portfolio profesional y tiene como objetivo demostrar la implementación de prácticas DevOps modernas con enfoque en modularidad, automatización y despliegue multiambiente.

## 🧰 Tecnologías utilizadas

- **Terraform**
- **AWS ECS**
- **AWS ECR**
- **AWS Fargate**
- **AWS VPC / Subnets / Security Groups**
- **Load Balancer (ALB)**
- **Módulos reutilizables de Terraform**
- **Ambientes separados: Dev, Test, Prod**

## 📁 Estructura del proyecto

\`\`\`
generic_terraform/
├── modules/              # Módulos reutilizables
│   ├── network/
│   ├── security/
│   ├── loadbalancer/
│   └── instances/
├── envs/                 # Configuraciones por entorno
│   ├── dev/
│   ├── test/
│   └── prod/
├── main.tf               # Orquestador principal
├── provider.tf           # Configuración del proveedor AWS
├── variables.tf          # Variables globales
├── outputs.tf            # Salidas clave
├── .gitignore
└── README.md
\`\`\`

## 🚀 Instalación y uso

### 1. Prerrequisitos

- Tener una cuenta en AWS y configurar las credenciales (`aws configure`)
- Tener instalado:
  - [Terraform](https://developer.hashicorp.com/terraform/downloads)
  - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
  - Git

### 2. Clonación del repositorio

\`\`\`bash
git clone https://github.com/macedofelipecosta/generic_terraform.git
cd generic_terraform
\`\`\`

### 3. Inicializar Terraform

\`\`\`bash
terraform init
\`\`\`

### 4. Seleccionar entorno y aplicar

\`\`\`bash
cd envs/dev     # O test / prod
terraform plan
terraform apply
\`\`\`

> 🔐 **Nota:** Asegurate de tener tus credenciales de AWS correctamente configuradas antes de aplicar.

## 🎯 Objetivos del proyecto

- Desplegar aplicaciones contenerizadas con **ECS Fargate**
- Gestionar imágenes Docker en **ECR**
- Diseñar redes seguras con **VPC y Security Groups**
- Reutilizar infraestructura mediante **módulos**
- Mantener entornos separados: **Dev, Test y Prod**

## 📝 Licencia

Este proyecto se encuentra bajo la licencia [MIT](LICENSE).

## ✍️ Autor

**Felipe Macedo Costa**  
[macedofelipecosta@icloud.com](mailto:macedofelipecosta@icloud.com)  
[LinkedIn](https://www.linkedin.com/in/felipemacedocosta/)
