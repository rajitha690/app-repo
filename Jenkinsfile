pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'MySonarQube' // This must match your SonarQube server name in Jenkins config
    }

    stages {

        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv("${env.SONARQUBE_ENV}") {
                        def scannerHome = tool name: 'SonarScanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
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
                sh './build.sh' // Make sure this file exists and is executable
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.currentResult == 'SUCCESS' }
            }
            steps {
                echo "Deploying Application..."
                sh './deploy.sh' // Same here
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
