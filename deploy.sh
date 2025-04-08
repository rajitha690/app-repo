#!/bin/bash

echo "Starting deployment..."

# Assuming your app runs on Flask
# Just confirming it's running on port 5000
if lsof -i:5000; then
    echo "App is already running on port 5000."
else
    echo "App is not running. Starting it..."
    source venv/bin/activate
    nohup python app.py > app.log 2>&1 &
fi

echo "Deployment complete."
