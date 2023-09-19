pipeline {
agent {
        kubernetes {
            label 'slave'
            yamlFile 'build-pod.yaml'
            defaultContainer 'ez-docker-helm-build'
        }
}

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials') // Create a Jenkins credential for Docker Hub
    }

    stages {
        stage('Checkout') {
            steps {
                // Check out the Git repository
                checkout([$class: 'GitSCM', 
                    branches: [[name: 'main']], // Specify the branch name
                    userRemoteConfigs: [[url: 'https://github.com/linschneider/finalproject.git']]]) // Update the repository URL
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    def dockerImage = docker.build("linschneider/finalproject", "-f Dockerfile .")

                    // Log in to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        // Push the Docker image to Docker Hub
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
