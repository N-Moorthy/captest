pipeline {
  agent any
  environment {
        DOCKER_CREDENTIALS_ID = 'dockercreds'
    }
  stages {
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
