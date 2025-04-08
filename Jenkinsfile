pipeline {
    agent any

    environment {
        VENV_DIR = "${WORKSPACE}/venv"
    }

    stages {
        stage('Build') {
            steps {
                echo 'Running Build Step...'
                sh '''
                    set -e

                    echo "Creating virtual environment..."
                    python3 -m venv venv

                    echo "Activating venv..."
                    . venv/bin/activate

                    echo "Upgrading pip..."
                    pip install --upgrade pip

                    echo "Installing dependencies..."
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Running Deploy Step...'
                sh '''
                    echo "Activating venv..."
                    . venv/bin/activate

                    echo "Starting the app..."
                    python app.py
                '''
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed. Please check the logs!'
        }
        always {
            echo 'Pipeline execution completed.'
        }
    }
}
