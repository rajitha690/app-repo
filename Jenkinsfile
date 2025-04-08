pipeline {
    agent any

    environment {
        // Optional: define credentials/paths here
        SONARQUBE_ENV = 'MySonarQube' // replace with your actual SonarQube config name in Jenkins
    }

    options {
        timestamps()
        ansiColor('xterm')
    }

    stages {
        stage('Quality Gate') {
            steps {
                script {
                    // Start Sonar analysis
                    withSonarQubeEnv("${SONARQUBE_ENV}") {
                        sh 'sonar-scanner' // or your custom Sonar command
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
                sh 'echo Simulating build step' // replace with your actual build command
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                echo '🚀 Deploying the application...'
                sh 'echo Simulating deploy step' // replace with your actual deployment script
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
