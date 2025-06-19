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

       stage('Docker Login with Username/Password') {
            steps {
                withCredentials([
                    usernamePassword(
                    credentialsId: 'docker-token',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )
                        ]) {
            sh '''
                echo "$DOCKERHUB_PASS" | \
                docker login -u "$DOCKERHUB_USER" --password-stdin
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
