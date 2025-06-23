# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
# Ensure gunicorn is in requirements.txt or install it separately
RUN pip install --no-cache-dir -r requirements.txt

# Install Docker client (for executing user code in isolated containers)
RUN apt-get update && \
    apt-get install -y --no-install-recommends docker.io && \
    rm -rf /var/lib/apt/lists/*
# If gunicorn is not in requirements.txt, uncomment the next line or add it to the file
# RUN pip install --no-cache-dir gunicorn

# Copy the backend application code into the container
COPY ./backend ./backend
COPY ./instance ./instance

# Render will set the PORT environment variable, and Gunicorn will use it.
# No EXPOSE needed here as Render handles port mapping.

# Define the command to run the application
# Gunicorn will listen on the port specified by the PORT environment variable.
CMD ["gunicorn", "--workers", "2", "--bind", "0.0.0.0:$PORT", "backend:create_app()"]
