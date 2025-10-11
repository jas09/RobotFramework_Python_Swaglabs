pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-repo/Swaglabs_RobotFramework.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'pip install -r requirements.txt'
            }
        }

        stage('Run Robot Tests') {
            steps {
                bat 'pabot --outputdir results tests/'
            }
        }

        stage('Publish Results') {
            steps {
                robot {
                    outputPath 'results'
                    outputFileName 'output.xml'
                    logFileName 'log.html'
                    reportFileName 'report.html'
                    passThreshold 100.0
                    unstableThreshold 80.0
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/**', allowEmptyArchive: true
        }
    }
}
