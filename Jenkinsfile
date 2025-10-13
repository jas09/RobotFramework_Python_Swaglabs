pipeline {
    agent any

    environment {
        ROBOT_OPTIONS = "--outputdir results"
        JIRA_API_TOKEN = credentials('c2bde01a-7d45-428f-8264-703efb5f0d18')  // Stored securely in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/jas09/RobotFramework_Python_Swaglabs.git', branch: 'main'
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
				if (fileExists('results/output.xml')){
                robot {
                    outputPath 'results'
                    outputFileName 'output.xml'
                    logFileName 'log.html'
                    reportFileName 'report.html'
                    passThreshold 100.0
                    unstableThreshold 80.0
                }
				} else {
					echo "Robot output not found. Skipping publish."
					}
            }
        }

        /*
        stage('Update Jira') {
            steps {
                script {
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
            archiveArtifacts artifacts: 'results/*.*', fingerprint: true
        }
    }
}
