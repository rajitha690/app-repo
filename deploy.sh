#!/bin/bash

echo "Starting deployment..."

cd $WORKSPACE/app-repo

# Activate virtual environment
source venv/bin/activate

# Kill any process running on port 5000 (optional safety step)
fuser -k 5000/tcp || true

# Start the app in the background with nohup
nohup python app.py > app.log 2>&1 &

echo "Deployment complete."
