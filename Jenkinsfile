pipeline {
    agent any

    environment {
        SONARQUBE = 'MySonarQubeServer' // Update with your SonarQube installation name
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/dimpleswapna/app-repo.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE}") {
                    sh 'sonar-scanner'
                }
            }
        }

        stage('Wait for Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Build') {
            steps {
                sh '''
                    chmod +x build.sh
                    ./build.sh
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    chmod +x deploy.sh
                    ./deploy.sh
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
        failure {
            echo 'Pipeline failed. Please check the logs!'
        }
    }
}
