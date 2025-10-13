pipeline {
    agent any

    options {
        skipDefaultCheckout(false)
        disableConcurrentBuilds()
    }

    triggers {
        githubPush()
    }

    environment {
        ROBOT_OPTIONS = "--outputdir results"
        JIRA_API_TOKEN = credentials('c2bde01a-7d45-428f-8264-703efb5f0d18')
    }

    stages {
        stage('Checkout') {
            steps {
                deleteDir()
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                bat '''
                    python -m venv venv
                    call venv\\Scripts\\activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Robot Tests (Parallel)') {
            steps {
                bat '''
                    call venv\\Scripts\\activate
                    mkdir results
                    pabot %ROBOT_OPTIONS% tests/
                '''
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
            archiveArtifacts artifacts: 'results/*.*', fingerprint: true
        }
    }
}
