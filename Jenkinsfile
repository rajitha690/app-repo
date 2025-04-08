pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'MySonarQube' // This must match the name in Jenkins > Global Tool Configuration
    }

    stages {
        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv("${env.SONARQUBE_ENV}") {
                        withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
                            def scannerHome = tool name: 'SonarScanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
                            sh """
                                ${scannerHome}/bin/sonar-scanner \
                                -Dsonar.login=$SONAR_TOKEN
                            """
                        }
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
                timeout(time: 10, unit: 'MINUTES') {
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
                sh 'chmod +x build.sh && ./build.sh'
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.currentResult == 'SUCCESS' }
            }
            steps {
                echo "Deploying Application..."
                sh 'chmod +x deploy.sh && ./deploy.sh'
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
