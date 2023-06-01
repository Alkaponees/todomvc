pipeline {
//     environment {
//     GITHUB_TOKEN=credentials('github-token')
//     IMAGE_NAME='ghcr.io/alkaponees/todomvc'
//     IMAGE_VERSION='v1'
//   }
   agent any
    stages {
        stage('Work with Docker agent on node image'){
            agent {
            docker {
                image 'node:14'
                args '-u root'
            }
        }
        stages{
            stage('Install dependencies'){
                steps {
                sh 'apt-get update && apt-get install -y wget gnupg ca-certificates git'
                sh 'apt-get update && apt-get install -y \
                    libgtk2.0-0 \
                    libgtk-3-0 \
                    libgbm-dev \
                    libnotify-dev \
                    libgconf-2-4 \
                    libnss3 \
                    libxss1 \
                    libasound2 \
                    libxtst6 \
                    xauth \
                    xvfb \
                    x11-xserver-utils'
              
            }
            }
            stage('Install npm'){
                steps{
                    sh 'npm install'
                    sh 'npm install cypress'
                }
        }
        stage('Build'){
            steps{
                sh 'npm run build'
            }
        }
        stage ('Test')
        {
            steps{
                sh 'npm start'
                sh 'npm run cypress:run'
            }
        }
        }
        
        }
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
    // stage('push image') {
    //   steps {
    //     sh 'docker push $IMAGE_NAME:$IMAGE_VERSION'
    //   }
    // }