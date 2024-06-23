pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        sh './build.sh'
      }
    }

    stage('Deploy & push') {
      steps {
        withCredentials([usernamePassword(credentialsId: "${DOCKER_REGISTRY_CREDS}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
          sh './deploy.sh'
        }
      }
    }

  }

}
