pipeline {
   agent none
   def app
  stages {
    stage('CLONE GIT REPOSITORY') {
      agent {
        label 'ubuntu-Appserver-3120'
      }
      steps {
        checkout scm
      }
    }

    stage('SCA-SAST-SNYK-TEST') {
      agent {
        label 'ubuntu-Appserver-3120'
      }
      steps {
        echo "SNYK-TEST"
      }
    }

    stage('BUILD-AND-TAG') {
      agent {
        label 'ubuntu-Appserver-3120'
      }
      steps {
        script {
          // Ensure Docker builds the image with the correct context and tag
          app = docker.build("amalan01/snakegame1")
          app.tag("latest")
        }
      }
    }

    stage('POST-TO-DOCKERHUB') {    
            agent {
                label 'ubuntu-Appserver-3120'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials') {
                        app = docker.image("amalan01/snakegame1")
                        app.push("latest")
                    }
                }
            }
        }

    stage('DEPLOYMENT') {
      agent {
        label 'ubuntu-Appserver-3120'
      }
      steps {
        sh "docker-compose down"
        sh "docker-compose up -d"
      }
    }
  }
}
