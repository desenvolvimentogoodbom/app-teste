pipeline {
  agent any

  stages {    
    stage('Check Docker/Compose') {
      steps {
        sh 'docker version'
        sh 'docker compose version'
      }
    }

    stage('Build and Deploy') {
      steps {
        script {
          // encerra containers antigos e sobe novamente
          sh 'docker compose down --remove-orphans'
          sh 'docker compose up -d --build'
        }
      }
    }
  }

  post {
    always {
      script {
        // cuidado: isso remove imagens não usadas do host
        sh 'docker system prune -af || true'
      }
    }
    success { echo 'Deployment successful!' }
    failure { echo 'Deployment failed!' }
  }
}
