pipeline {
    agent any

    tools {
        maven 'maven_3_5_0'
    }

    environment {
        DOCKER_IMAGE = "adityayevate/dockerapp:latest"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/adityayevate/ise3'
            }
        }

        stage('Build Java Application') {
            steps {
                bat 'mvn -B clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKER_IMAGE% ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: dockerhub-login, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat """
                        echo %DOCKER_PASS% | docker login --username adityayevate --password-stdin
                        docker push %DOCKER_IMAGE%
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Docker image built and pushed successfully!"
        }
        failure {
            echo "❌ Build or push failed!"
        }
    }
}
