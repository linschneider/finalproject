# Stage 1: Build the Jenkins Agent
FROM jenkins/inbound-agent:4.10 AS jenkins-agent

USER root

# Install Docker
RUN apt-get update && apt-get install -y docker.io

RUN usermod -aG docker jenkins

USER jenkins

# Stage 2: Build the Python Application on top of the Jenkins Agent
FROM jenkins-agent AS python-app

# Use the official Python image as a parent image
FROM python:3.8-slim-buster

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
