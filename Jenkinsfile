pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'MySonarQube'
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
                            currentBuild.result = 'FAILURE'
                            error "Aborting pipeline due to Quality Gate failure"
                        } else {
                            echo "✅ Quality Gate passed: ${qg.status}"
                        }
                    }
                }
            }
        }

        stage('Build') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                echo "🛠️ Building the application..."
                // Example build command
                // sh 'docker build -t my-app .'
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                echo "🚀 Deploying the application..."
                // Example deployment step
                // sh './deploy.sh'
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
