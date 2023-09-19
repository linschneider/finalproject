# Use a base image with Docker installed
FROM docker:20.10 AS docker-base

# Build stage for the custom Jenkins agent
FROM jenkins/inbound-agent:4.10 AS jenkins-agent

USER root

# Install Docker CLI (docker) in the Jenkins agent
COPY --from=docker-base /usr/local/bin/docker /usr/local/bin/docker

USER jenkins

# Copy any additional dependencies or configurations needed for your agent
# For example:
# COPY some-files /opt/some-files

# Stage 2: Build the Python Application on top of the Jenkins Agent
FROM jenkins-agent AS python-app

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Copy the contents of the current directory into the container at /app
COPY . .

# Expose port 5000 for the Flask app
EXPOSE 5000

# Start the Flask app
CMD ["python", "app_backend.py"]
