pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'jjberlanga99/django-api'
        IMAGE_TAG = "build-${BUILD_NUMBER}"
    }

    stages {

        stage('Test (Python container)') {
            agent {
                docker {
                    image 'python:3.14.4'
                }
            }
            steps {
                sh 'pip install -r requirements.txt'
                sh 'python manage.py test'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$IMAGE_TAG -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE:$IMAGE_TAG'
                    sh 'docker push $DOCKER_IMAGE:latest'
                }
            }
        }

        stage('Deploy Local Container') {
            steps {
                sh 'docker stop django-api || true'
                sh 'docker rm django-api || true'
                sh 'docker run -d --name django-api -p 8000:8000 $DOCKER_IMAGE:latest'
            }
        }

        stage('Health Check') {
            steps {
                sh 'sleep 5'
                sh 'curl -f http://host.docker.internal:8000/api/health/'
            }
        }

        stage('Deploy to Azure Container Apps') {
            steps {
                withCredentials([
                    string(credentialsId: 'azure-client-id', variable: 'AZURE_CLIENT_ID'),
                    string(credentialsId: 'azure-client-secret', variable: 'AZURE_CLIENT_SECRET'),
                    string(credentialsId: 'azure-tenant-id', variable: 'AZURE_TENANT_ID'),
                    string(credentialsId: 'azure-subscription-id', variable: 'AZURE_SUBSCRIPTION_ID')
                ]) {
                    sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID'
                    sh 'az account set --subscription $AZURE_SUBSCRIPTION_ID'
                    sh 'az containerapp update --name django-api --resource-group rg-devops-django --image $DOCKER_IMAGE:$IMAGE_TAG'
                }
            }
        }
    }
}