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
           // Build the Docker image with the correct context and tag
           app = docker.build("amalan01/snakegame1:latest", ".")
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
             // Push the previously built image
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

   post {
     always {
       cleanWs() // Clean workspace after the build to prevent clutter
     }
   }
}
