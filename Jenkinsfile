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
                    def branch = env.BRANCH_NAME ?: 'prod'
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
            environment {
                DOCKERHUB_CREDENTIALS = credentials("${DOCKER_CREDENTIALS_ID}")
            }
            steps {
                script {
                    withEnv(["DOCKER_USERNAME=${env.DOCKERHUB_CREDENTIALS_USR}", "DOCKER_PASSWORD=${env.DOCKERHUB_CREDENTIALS_PSW}"]) {
                        sh 'chmod +x deploy.sh'
                        sh './deploy.sh'
                    }
                }
            }
        }
    }
}
