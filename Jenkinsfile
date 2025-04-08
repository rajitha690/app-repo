pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'MySonarQube' // Replace with your actual SonarQube config name in Jenkins
    }

    options {
        timestamps()
    }

    stages {
        stage('Quality Gate') {
            steps {
                script {
                    withSonarQubeEnv("${SONARQUBE_ENV}") {
                        sh 'sonar-scanner'
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
                ansiColor('xterm') {
                    echo '📦 Building the application...'
                    sh 'echo Simulating build step'
                }
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                ansiColor('xterm') {
                    echo '🚀 Deploying the application...'
                    sh 'echo Simulating deploy step'
                }
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
