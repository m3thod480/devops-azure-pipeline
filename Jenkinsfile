pipeline {
    agent any

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
                sh 'docker build -t django-api .'
            }
        }
    }
}