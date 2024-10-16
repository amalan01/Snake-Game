pipeline 
{
  agent none

  stages
  {
    stage('CLONE GIT REPOSITORY')
    {
      agent
      {
        label 'ubuntu-Appserver-3120'
      }
      steps 
      {
        checkout scm
      }
    }

    stage('SCA-SAST-SNYK-TEST')
    {
      agent
      {
        label 'ubuntu-Appserver-3120'
      }
      steps 
      {
        echo "SNYK-TEST"
      }
    }

     stage('BUILD-AND-TAG')
    {
      agent
      {
        label 'ubuntu-Appserver-3120'
      }
      steps 
      {
         script 
         {
            def app = docker.build("amalan01/snake")
            app.tag("latest")
         }
      }
    }

      stage('POST-TO-DOCKERHUB')
    {
      agent
      {
        label 'ubuntu-Appserver-3120'
      }
      steps 
      {
         script 
         {
            docker.withRegistry("https://registry.hub.docker.com", "dockerhub_credentials")
            {
                def app = docker.image("amalan01/snake")
                app.push("latest")

            }
            
         }
      }
    }

    stage('DEPLOYMENT')
    {
      agent
      {
        label 'ubuntu-Appserver-3120'
      }
      steps 
      {
        sh "docker-compose down"
        sh "docker-compose up -d"
      }
    }

    
    
  }
  
}


