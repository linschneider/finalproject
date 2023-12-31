FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Install any needed packages specified in requirements.txt
RUN pip install flask pymongo pytest

COPY app /app

# Expose port for the Flask app (if needed)
EXPOSE 9101

CMD ["app.py"]


# Start the Flask app or your application as needed
ENTRYPOINT ["python3"]
