FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY .

# Install any needed packages specified in requirements.txt
RUN pip install flask pymongo

# Expose port 5000 for the Flask app (if needed)
EXPOSE 5000

# Start the Flask app or your application as needed
CMD ["python", "app_backend.py"]
