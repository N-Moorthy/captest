pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockercreds'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                script {
                    // Ensure BRANCH_NAME is set, defaulting to 'prod' if not specified
                    def branch = env.BRANCH_NAME ?: 'dev'
                    echo "Checking out branch: ${branch}"
                    
                    // Checkout SCM using Git plugin
                    checkout([$class: 'GitSCM',
                              branches: [[name: "*/${branch}"]],
                              doGenerateSubmoduleConfigurations: false,
                              extensions: [],
                              userRemoteConfigs: [[url: 'https://github.com/N-Moorthy/captest.git',
                                                   credentialsId: 'gitcreds']]])
                }
            }
        }

        stage('Build') {
            steps {
                sh 'chmod +x build.sh'
                sh './build.sh'
            }
        }

        stage('Deploy & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'chmod +x deploy.sh'
                        docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                        ./deploy.sh
                    '''
                }
            }
        }
    }
}
