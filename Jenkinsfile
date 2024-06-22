pipeline {
  agent any
  environment {
  DOCKER_HUB_CREDENTIALS = credentials('DOCKER_HUB_CREDENTIALS')
}	
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t myimg .'
        sh 'docker tag myimg $DOCKER_BFLASK_IMAGE'
      }
    }
    stage('Deploy & push') {
      steps {
        withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDENTIALS}", passwordVariable: 'DOCKER_HUB_CREDENTIALS_PSW', usernameVariable: 'DOCKER_HUB_CREDENTIALS_USR')]) {
          sh "echo \$DOCKER_HUB_CREDENTIALS_PSW | docker login -u \$DOCKER_HUB_CREDENTIALS_USR --password-stdin docker.io"
          sh 'docker push $DOCKER_BFLASK_IMAGE'
        }
      }
    }
    
  }

post{
      always{
            sh 'docker run -d -p 80:80 hanumith/prodcapstone:latest'
}

}
}
