pipeline {
    agent any
    environment {
        IMAGE_NAME = 'liortal26/my-nginx'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('create tag by date') {
            steps {
                script {
                    IMAGE_TAG = sh(script: "date +'%y%m%d%H%M'", returnStdout: true).trim()
                }
            }
        }
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-token', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
                    sh 'echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USER" --password-stdin'
                }
            }
        }
        stage('Build Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }
        stage('Push Image') {
            steps {
                sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }
}
