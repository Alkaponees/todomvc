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
                image 'ubuntu:latest'
                args '-u root'
            }
        }
        stages{
            stage('Install dependencies'){
                steps {
                sh 'apt-get update && apt-get install -y wget gnupg  git curl dirmngr apt-transport-https lsb-release ca-certificates netcat-openbsd net-tools iftop iproute2 iputils-ping dnsutils traceroute'
                sh 'curl -sL https://deb.nodesource.com/setup_14.x | bash -'
                sh 'apt-get install nodejs'
                sh 'node -v && npm -v'
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
            stage ('Check network connection')
            {
                steps{
                    sh 'ping -c 5 www.google.com'
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