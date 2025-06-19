pipeline {
    agent any

    environment {
        IMAGE_NAME = 'liortal26/my-nginx'
    }

    stages {
        stage('Clone') {
            steps {
                git url: 'https://github.com/LiorTal26/CI-nginx-test.git', branch: 'main'
            }
        }

        stage('create tag by date') {
            steps {
                script {
                    env.IMAGE_TAG = sh(script: "date +'%y%m%d%H%M'",returnStdout: true).trim()
                }
                echo "Using tag: ${env.IMAGE_TAG}"
            }
        }

        stage('docker login with token') {
            steps {
                withCredentials([ 
                    string(credentialsId: 'docker-token', variable: 'DOCKERHUB_TOKEN') 
                ]) {
                    sh '''
                        echo "$DOCKERHUB_TOKEN" | \
                        docker login -u "liortal26" --password-stdin
                    '''
                }
            }
        }

        stage('Build & Push') {
            steps {
                sh """
                     docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                     docker push ${IMAGE_NAME}:${IMAGE_TAG}
                """
            }
        }
    }
}
