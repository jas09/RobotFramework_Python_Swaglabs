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
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Robot Tests (Parallel)') {
            steps {
                bat '''
                    . venv/bin/activate
                    mkdir -p results
                    pabot $ROBOT_OPTIONS tests/
                '''
            }
        }

        stage('Publish Results') {
            steps {
                publishRobotResults logFileName: 'output.xml', outputPath: 'results'
            }
        }
		/*
        stage('Update Jira') {
            steps {
                script {
                    def storyKey = sh(script: "git log -1 --pretty=%B | grep -oE '[A-Z]+-[0-9]+'", returnStdout: true).trim()
                    if (storyKey) {
                        bat """
                            curl -X POST \
                            -H "Authorization: Bearer ${JIRA_API_TOKEN}" \
                            -H "Content-Type: application/json" \
                            -d '{"transition": {"id": "31"}}' \
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
