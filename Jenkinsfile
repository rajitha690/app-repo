pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'MySonarQube'  // Replace with your SonarQube config name
    }

    stages {
        stage('SonarQube Analysis') {
            steps {
                script {
                    wrap([$class: 'AnsiColorBuildWrapper', colorMapName: 'xterm']) {
                        withSonarQubeEnv("${SONARQUBE_ENV}") {
                            sh '/opt/sonar-scanner/bin/sonar-scanner'
                        }
                    }
                }
            }
        }

        stage('Wait for Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    script {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            echo "❌ Quality Gate failed: ${qg.status}"
                            // Optional: Send alert here
                        } else {
                            echo "✅ Quality Gate passed"
                        }
                    }
                }
            }
        }

        stage('Build') {
            steps {
                echo "🛠️ Building the application..."
                // Add build commands here (e.g., Docker build, Maven build, etc.)
            }
        }

        stage('Deploy') {
            steps {
                echo "🚀 Deploying the application..."
                // Add deployment steps here
            }
        }
    }

    post {
        always {
            echo '📦 Pipeline completed.'
        }
        failure {
            echo '❌ Pipeline failed.'
        }
    }
}
