pipeline {
    environment {
    GITHUB_TOKEN=credentials('github-token')
    IMAGE_NAME='alkaponees/todomvc'
    IMAGE_VERSION='v1'
    HOME='.'
  }
   agent {
    docker {
        image 'node:14'
        args '-p 3000:8080 -u root'
        
    }
        }
    stages {
        stage ('Install dependencies'){
            
        steps {
                sh 'apt-get update && apt-get install -y wget gnupg ca-certificates git xvfb'
                sh 'npm install'
              
            }
        }
        stage('Install cypress'){
            steps{
                sh 'npm install cypress --save-dev'
            }
        }
        stage ('Build')
        {
            steps{
                sh 'npm run build'
                
            }
        }
        stage ('Test')
        {
            steps{
                sh 'npm run cypress:run'
            }
        }
            
       
    //     stage ('Create docker conatiner')
    //     {
    //         steps{
    //             sh 'docker build -t $IMAGE_NAME:$IMAGE_VERSION .'
    //         }
    //     }    
    //     stage('login to GHCR') {
    //   steps {
    //     sh 'echo $GITHUB_TOKEN_PSW | docker login ghcr.io -u $GITHUB_TOKEN_USR --password-stdin'
    //   }
    // }
    // stage('tag image') {
    //   steps {
    //     sh 'docker tag $IMAGE_NAME:$IMAGE_VERSION ghcr.io/$IMAGE_NAME:$IMAGE_VERSION'
    //   }
    // }
    // stage('push image') {
    //   steps {
    //     sh 'docker push ghcr.io/$IMAGE_NAME:$IMAGE_VERSION'
    //   }
    // }

    }
}