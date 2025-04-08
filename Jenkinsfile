pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'MySonarQube'
    }

    options {
        timestamps()
    }

    stages {
        stage('Quality Gate') {
            steps {
                script {
                    withSonarQubeEnv("${SONARQUBE_ENV}") {
                        sh '/opt/sonar-scanner/bin/sonar-scanner'
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
                            error "❌ Quality Gate failed: ${qg.status}"
                        } else {
                            echo "✅ Quality Gate passed"
                        }
                    }
                }
            }
        }

        stage('Build') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                echo '📦 Building the application...'
                sh 'echo Simulating build step'
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                echo '🚀 Deploying the application...'
                sh 'echo Simulating deploy step'
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
