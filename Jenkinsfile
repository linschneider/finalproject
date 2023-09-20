pipeline {
    agent {
        kubernetes {
            label 'flask-app'
            yamlFile 'build-pod.yaml'
            defaultContainer 'docker-helm-build' // Corrected container name
        }
    }

    environment {
        DOCKER_REGISTRY = 'https://registry.hub.docker.com'
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials') 
    }

    stages {
        stage('Test Docker') {
            steps {
                script {
                    sh 'docker --version'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        echo 'Starting Docker build...'
                        
                        // Clone the Git repository into the workspace
                        checkout([$class: 'GitSCM', 
                            branches: [[name: 'main']], // Specify the branch name
                            userRemoteConfigs: [[url: 'https://github.com/linschneider/finalproject.git']]]) // Update the repository URL
                        
                        // Build the Docker image from the current directory
                        def dockerImage = docker.build("linschneider/finalproject", "-f Dockerfile .")
                        echo 'Docker build completed.'
                    } catch (Exception e) {
                        // Print detailed error information
                        echo "Error: ${e.message}"
                        currentBuild.result = 'FAILURE'
                        error("Docker build failed")
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo 'Starting Docker push...'

                                steps {
                script {
                    def dockerImage = docker.build("linschneider/finalproject", "-f Dockerfile .")
                    // Log in to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        // Push the Docker image to Docker Hub
                        dockerImage.push()
                    }
                }

                    echo 'Docker push completed.'
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image pushed successfully.'
        }
    }
}
