pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'SonarQube' // Name as per your Jenkins config
    }

    stages {

        stage('Quality Gate') {
            steps {
                script {
                    withSonarQubeEnv("${env.SONARQUBE_ENV}") {
                        sh 'sonar-scanner' // Or use mvn sonar:sonar if it's a Maven project
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
                sh './build.sh' // replace with your build command
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.currentResult == 'SUCCESS' }
            }
            steps {
                echo "Deploying Application..."
                sh './deploy.sh' // replace with your deploy command
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
