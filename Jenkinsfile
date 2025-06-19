pipeline {
    agent any
    environment {
        IMAGE_NAME = 'liortal26/my-nginx'
        IMAGE_TAG  = ''
    }
    stages {
        stage('Clone') {
            steps {
                git url: 'https://github.com/LiorTal26/CI-nginx-test.git', branch: 'main'
            }
        }
        stage('Create Tag by Date') {
            steps {
                script {
                    def tag = sh(script: "date +'%y%m%d%H%M'", returnStdout: true).trim()
                    env.IMAGE_TAG = tag
                }
                echo "Using tag ${env.IMAGE_TAG}"
            }
        }
        stage('Docker Login') {
            steps {
                withCredentials([ string(credentialsId: 'docker-token', variable: 'DOCKERHUB_TOKEN') ]) {
                    sh '''
                      echo "$DOCKERHUB_TOKEN" | docker login -u "liortal26" --password-stdin
                    '''
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
