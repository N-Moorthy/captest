pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockercreds'
        DOCKER_USERNAME = credentials('docker-username')
        DOCKER_PASSWORD = credentials('docker-password')
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code
                checkout scm
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Fetch the current branch name
                    def branchName = env.BRANCH_NAME

                    // Execute the deploy.sh script with the current branch name
                    sh """
                    chmod +x build.sh deploy.sh
                    BRANCH_NAME=${branchName} ./deploy.sh
                    """
                }
            }
        }
    }
}

