# 🚀 DevOps Azure Full Pipeline (Docker + Jenkins + Terraform)

Proyecto end-to-end de CI/CD enfocado a prácticas reales de DevOps y despliegue en la nube.

---

## 📌 Descripción

Este proyecto implementa un flujo completo de integración y despliegue continuo (CI/CD) para una API desarrollada en Python (Django), incluyendo:

* Construcción automática de imágenes Docker
* Ejecución de tests en pipeline
* Publicación en Docker Hub
* Despliegue automático en Azure Container Apps
* Infraestructura definida como código con Terraform
* Gestión de estado remoto (backend en Azure Storage)

El objetivo ha sido simular un entorno real de producción, enfrentando problemas reales como gestión de permisos, sincronización del estado y despliegues fallidos.

---

## 🏗️ Arquitectura

```text
GitHub
   ↓
Jenkins (CI/CD Pipeline)
   ↓
Docker Build → Docker Hub
   ↓
Terraform (IaC)
   ↓
Azure Container Apps
```

---

## ⚙️ Tecnologías utilizadas

* 🐍 Python (Django)
* 🐳 Docker
* 🔁 Jenkins (CI/CD)
* ☁️ Azure (Container Apps)
* 🏗️ Terraform (Infrastructure as Code)
* 🔐 Azure Service Principal (autenticación)
* 🗂️ Azure Storage (backend remoto de Terraform)
* 🔧 Git / GitHub

---

## 🔄 Pipeline CI/CD

El pipeline implementado en Jenkins realiza automáticamente:

1. 🧪 Ejecución de tests en contenedor Python
2. 🐳 Build de la imagen Docker
3. 📦 Push a Docker Hub (versionado por build)
4. 🚀 Despliegue mediante Terraform
5. ❤️ Health check tras despliegue

---

## ☁️ Infraestructura (Terraform)

La infraestructura se define mediante Terraform:

* Resource Group
* Container App Environment
* Azure Container App
* Configuración de ingress público
* Backend remoto en Azure Storage

---

## 🔐 Autenticación

El acceso a Azure se realiza mediante:

* Service Principal
* Variables de entorno (`ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, etc.)

Esto permite ejecutar Terraform desde Jenkins sin intervención manual.

---

## 📂 Estructura del proyecto

```text
.
├── Jenkinsfile
├── Dockerfile
├── requirements.txt
├── manage.py
├── app/
└── infra/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
```

---

## 🚀 Ejecución local

```bash
docker build -t django-api .
docker run -p 8000:8000 django-api
```

---

## 🧠 Aprendizajes clave

Durante el desarrollo del proyecto:

* Gestión de permisos en Azure (RBAC)
* Uso de backend remoto en Terraform
* Integración real entre herramientas DevOps
* Resolución de errores en despliegues cloud
* Automatización completa del ciclo de vida de la aplicación

---

## 📌 Mejoras futuras

* Separación de entornos (dev / prod)
* Integración con Azure Container Registry (ACR)
* Logging y monitorización (Azure Monitor)
* Escalado automático y métricas
* Seguridad avanzada (Key Vault, Managed Identity)

---

## ⭐ Notas

Este proyecto está orientado a aprendizaje práctico en DevOps y cloud computing, simulando escenarios reales de trabajo.
