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
            def app = docker.build("amalan01/snakegame1")
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
                def app = docker.image("amalan01/snakegame1")
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


// node('ubuntu-Appserver-3120')
// {
//     def app
//     stage('Cloning Git')
//     {
//     /* Let's make sure we have the repository cloned to our workspace */
//     checkout scm
//     }

//       stage('SCA-SAST-SNYK-TEST') {
//        agent {
//          label 'ubuntu-Appserver-31201'
//        }
       
//          echo "SNYK-TEST"
//        }
     
//     stage('Build-and-Tag')
//     {
//         /* This builds the actual image; 
//         * This is synonymous to docker build on the command line */
//         app =docker.build("amalan06/snakegame1")
//     }
//     stage('Post-to-dockerhub')
//     {
//         docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials')
//         {
           
//          app.push("latest")
//         }
//     }

//     stage('Pull-image-server')
//     {
//         sh "docker-compose down"
//         sh "docker-compose up -d"
//     }

// }




