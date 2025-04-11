pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'MySonarQube'  // Name of the SonarQube server in Jenkins config
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
                script {
                    timeout(time: 15, unit: 'MINUTES') {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            echo "❌ Quality Gate failed: ${qg.status}"
                            error "Aborting pipeline due to Quality Gate failure"
                        } else {
                            echo "✅ Quality Gate passed: ${qg.status}"
                        }
                    }
                }
            }
        }

        stage('Build') {
            steps {
                echo "🛠️ Building the application..."
                // Example: sh 'docker build -t my-app .'
            }
        }

        stage('Deploy') {
            steps {
                echo "🚀 Deploying the application..."
                // Example: sh './deploy.sh'
            }
        }
    }

    post {
        always {
            echo '📦 Pipeline completed.'
        }
        success {
            echo '✅ Pipeline succeeded.'
        }
        failure {
            echo '❌ Pipeline failed.'
        }
    }
}
