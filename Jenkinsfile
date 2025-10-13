pipeline {
    agent any

    options {
        skipDefaultCheckout(false)
        disableConcurrentBuilds()
        durabilityHint('PERFORMANCE_OPTIMIZED')
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
                echo "Cleaning workspace and checking out latest code..."
                deleteDir() // Ensures no old commits or cached .git data remain
                checkout([$class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/jas09/RobotFramework_Python_Swaglabs.git'
                    ]],
                    extensions: [
                        [$class: 'WipeWorkspace'],
                        [$class: 'CleanBeforeCheckout'],
                        [$class: 'CloneOption', depth: 0, noTags: false, shallow: false, timeout: 15]
                    ]
                ])
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "Setting up Python virtual environment and installing dependencies..."
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
                echo "Executing Robot Framework tests in parallel using pabot..."
                bat '''
                    call venv\\Scripts\\activate
                    mkdir results
                    pabot %ROBOT_OPTIONS% tests/
                '''
            }
        }

        stage('Publish Results') {
            steps {
                echo "Publishing Robot Framework test results..."
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

        /*
        stage('Update Jira') {
            steps {
                script {
                    echo "Attempting to update Jira story status..."
                    def storyKey = bat(script: 'git log -1 --pretty=%B | findstr /R "[A-Z]*-[0-9]*"', returnStdout: true).trim()
                    if (storyKey) {
                        bat """
                            curl -X POST ^
                            -H "Authorization: Bearer ${JIRA_API_TOKEN}" ^
                            -H "Content-Type: application/json" ^
                            -d "{\\"transition\\": {\\"id\\": \\"31\\"}}" ^
                            https://neverabdicate.atlassian.net/rest/api/3/issue/${storyKey}/transitions
                        """
                    } else {
                        echo "No JIRA key found in commit message."
                    }
                }
            }
        }
        */
    }

    post {
        always {
            echo "Archiving Robot Framework reports..."
            archiveArtifacts artifacts: 'results/*.*', fingerprint: true
        }
        success {
            echo "✅ Build completed successfully!"
        }
        failure {
            echo "❌ Build failed. Please check logs and test results."
        }
    }
}
