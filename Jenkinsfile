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
        /* This builds the actual image; 
        * This is synonymous to docker build on the command line */
        app =docker.build("amalan06/snakegame1")
    }
    stage('POST-TO-DOCKERHUB')
    {
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials')
        {
           
         app.push("latest")
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







