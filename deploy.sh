#!/bin/bash

set -e

echo "Building Docker image..."
docker build -t my-app-image .

echo "Running container..."
docker run -d -p 5000:5000 --name my-app-container my-app-image

echo "Deployment complete!"
