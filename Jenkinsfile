pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Running Build Step...'
                sh '''
                    cd app-repo
                    python3 -m venv venv
                    source venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Running Deploy Step...'
                sh '''
                    cd app-repo
                    source venv/bin/activate
                    python app.py
                '''
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed. Please check the logs!'
        }
    }
}
