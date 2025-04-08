#!/bin/bash

set -e

echo "Installing dependencies..."
pip install -r requirements.txt

echo "Running unit tests..."
# python -m unittest discover  # Optional: if you have tests

echo "Build successful!"
