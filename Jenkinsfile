pipeline {
    agent any

    tools {
        maven 'Maven 3'
    }

    environment {
        DOCKER_IMAGE = "sakshishelake/dockerapp:latest"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Shelake04/ISE3'
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
                withCredentials([usernamePassword(credentialsId: '7bab7d88-7142-42e7-9ce6-ecc8593bf249', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat """
                        echo %DOCKER_PASS% | docker login --username sakshishelake --password-stdin
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
