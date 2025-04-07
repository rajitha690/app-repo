pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'MySonarQube' // Must match the configured SonarQube name
    }

    stages {

        stage('Quality Gate') {
            steps {
                script {
                    withSonarQubeEnv("${env.SONARQUBE_ENV}") {
                        def scannerHome = tool 'SonarScanner' // Must match the configured SonarScanner name
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
            post {
                success {
                    echo "Code analysis sent to SonarQube"
                }
                failure {
                    error "SonarQube analysis failed."
                }
            }
        }

        stage('Wait for Quality Gate Result') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    script {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Quality Gate failed: ${qg.status}"
                        }
                    }
                }
            }
        }

        stage('Build') {
            when {
                expression { currentBuild.currentResult == 'SUCCESS' }
            }
            steps {
                echo "Running Build..."
                sh './build.sh'
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.currentResult == 'SUCCESS' }
            }
            steps {
                echo "Deploying Application..."
                sh './deploy.sh'
            }
        }
    }

    post {
        failure {
            echo "Pipeline failed. Check logs."
        }
        success {
            echo "Pipeline completed successfully."
        }
    }
}
