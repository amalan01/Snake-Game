pipeline {
    agent {
        label 'ubuntu-Appserver-3120'
    }

    stages {
        stage('Cloning Git') {
            steps {
                script {
                    // Ensure the repository is cloned to the workspace
                    checkout scm
                }
            }
        }

        stage('SCA-SAST-SNYK-TEST') {
            agent {
                label 'ubuntu-Appserver-3120' // Separate agent for this specific stage
            }
            steps {
                echo "SNYK-TEST"
            }
        }

        stage('Build-and-Tag') {
            steps {
                script {
                    // Build the Docker image
                    def app = docker.build("amalan06/snakegame1")
                }
            }
        }

        stage('Post-to-dockerhub') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                        def app = docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials') {
                        app.push("latest")
                    }
                }
            }
        }

        stage('Pull-image-server') {
            steps {
                script {
                    // Stop and start the Docker containers using docker-compose
                    sh "docker-compose down"
                    sh "docker-compose up -d"
                }
            }
        }
    }
}
