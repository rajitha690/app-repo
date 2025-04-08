pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'MySonarQube' // Replace with your SonarQube config name in Jenkins
    }

    options {
        timestamps()
        ansiColor('xterm')
    }

    stages {
        stage('Quality Gate') {
            steps {
                script {
                    withSonarQubeEnv("${SONARQUBE_ENV}") {
                        sh '/opt/sonar-scanner/bin/sonar-scanner' // Make sure full path is used
                    }
                }
            }
        }

        stage('Wait for Quality Gate') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    script {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            echo "❌ Quality Gate failed: ${qg.status}"
                            // No error thrown, so pipeline continues
                        } else {
                            echo "✅ Quality Gate passed"
                        }
                    }
                }
            }
        }

        stage('Build') {
            steps {
                echo '📦 Building the application...'
                sh '''
                    python3 -m venv venv
                    source venv/bin/activate
                    pip install -r requirements.txt
                    python app.py
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploying the application...'
                sh 'echo Simulating deploy step' // Replace with your deployment command
            }
        }
    }

    post {
        success {
            echo '🎉 Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed.'
        }
    }
}
