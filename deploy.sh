#!/bin/bash

echo "Starting deployment..."

cd $WORKSPACE/app-repo

# Activate virtual environment
source venv/bin/activate

# Kill any app already running on port 5000
fuser -k 5000/tcp || true

# Start Flask app in the background
nohup python app.py > app.log 2>&1 &

echo "Deployment complete."
