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

        stage('Deploy & push') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh 'chmod +x deploy.sh'
                    sh './deploy.sh'
                }
            }
        }
    } 
} 
