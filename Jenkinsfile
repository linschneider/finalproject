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

        stage('Run Pytest') {
            steps {
                script {
                    try {
                        echo 'Running pytest...'

                        // Assuming you have a virtual environment set up for your Flask app
                        sh 'source venv/bin/activate && pytest -v'

                        echo 'Pytest completed.'
                    } catch (Exception e) {
                        // Print detailed error information
                        echo "Error: ${e.message}"
                        currentBuild.result = 'FAILURE'
                        error("Pytest failed")
                    } finally {
                        // Deactivate the virtual environment
                        sh 'deactivate'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push linschneider/finalproject:latest
                    '''
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
