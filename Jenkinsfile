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

        stage('Run Tests') {
            steps {
                // Execute your Python test script
                script {
                    try {
                        // Make sure Python is installed in the Docker container
                        sh 'docker exec -i docker-helm-build python --version'
                        
                        // Run your Python test script inside the Docker container
                        sh 'docker exec -i docker-helm-build python test.py'
                    } catch (Exception e) {
                        // Print detailed error information
                        echo "Error: ${e.message}"
                        currentBuild.result = 'FAILURE'
                        error("Test execution failed")
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        try {
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            sh 'docker push linschneider/finalproject:latest'
                            echo 'Docker image pushed successfully.'
                        } catch (Exception e) {
                            // Print detailed error information
                            echo "Error: ${e.message}"
                            currentBuild.result = 'FAILURE'
                            error("Docker image push failed")
                        }
                    }
                }
            }
        }
    }
}
