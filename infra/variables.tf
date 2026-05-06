variable "resource_group_name" {
  type    = string
  default = "rg-devops-django-tf"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "container_app_environment_name" {
  type    = string
  default = "env-devops-django-tf"
}

variable "container_app_name" {
  type    = string
  default = "django-api-tf"
}

variable "container_image" {
  type    = string
  default = "jjberlanga99/django-api:latest"
}