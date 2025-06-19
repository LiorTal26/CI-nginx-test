pipeline {
    agent any
    environment {
        IMAGE_NAME = 'liortal26/my-nginx'
        IMAGE_TAG = ''
    }
    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/LiorTal26/CI-nginx-test.git', branch: 'main'
            }
        }
        stage('Create Tag by Date') {
            steps {
                script {
                    env.IMAGE_TAG = sh(script: "date +'%y%m%d%H%M'", returnStdout: true).trim()
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
