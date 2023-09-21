**Jenkins Install**

**Prerequisites**

Before you begin, ensure you have the following prerequisites:

- Kubernetes cluster is up and running.
- Helm is installed on your system.


**Installation Steps**


**Install helm:**

- curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
- chmod +x get_helm.sh
- ./get_helm.sh




**Install Jenkins **
-  helm repo add jenkins https://charts.jenkins.io
- 
-  helm repo update
-  
-  helm install jenkins jenkins/jenkins --namespace jenkins

 **Retrieve Jenkins Admin Password**

- kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/   chart-admin-password
 
 **Access Jenkins**

- kubectl --namespace jenkins port-forward svc/jenkins 8080:8080`

Connect to Jenkins at http://localhost:8080/ using the username admin and the password obtained in the previous step.

 



**Adding Jenkins Pluggings**

 Log in to your Jenkins instance at http://localhost:8080/

- Click on "Manage Jenkins" in the Jenkins dashboard.

- Select "Manage Plugins" from the menu.

- Go to the "Available" tab.
 
- Search for and select the following plugins:
 
- Docker Plugin
- GitHub Plugin
- GitLab Plugin
- Kubernetes Plugin
- Click the "Download now and install after restart" button at the bottom of the page.

- Jenkins will download and install the selected plugins. After installation, Jenkins will prompt you to restart. Click "Restart Jenkins when the installation is complete and no jobs are running" to complete the installation.

Jenkins will restart with the newly added plugins


 
**Configure Jenkins Pipeline**
To build and push Docker images to DockerHub, create a Jenkins pipeline using the following Jenkinsfile. Make sure to modify the DockerHub credentials according to your DockerHub account.
 make sure to change the DockerHub cardential according to your DockerHub account


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


**Uninstall Jenkins**

To uninstall Jenkins, run the following commands:

-  helm uninstall <jenkins>
-  kubectl get pv
-  kubectl delete pv <pv-name>



