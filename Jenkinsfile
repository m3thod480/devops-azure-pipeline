pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'jjberlanga99/django-api'
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
                sh 'docker build -t $DOCKER_IMAGE:latest .'
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
                sh 'curl -f http://localhost:8000/api/health/'
            }
        }
    }
}