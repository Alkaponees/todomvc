pipeline {
    environment {
    GITHUB_TOKEN=credentials('github-token')
    IMAGE_NAME='ghcr.io/alkaponees/todomvc'
    IMAGE_VERSION='v1'
  }
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
            stage('Install'){
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
                sh 'npm install'
                sh 'npm install cypress'
              
            }
            }
        
        stage('Test'){
            steps{
                sh 'npm run build'
                sh 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
                        && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
                        && apt-get update \
                        && apt-get install -y google-chrome-stable'
                
                sh 'npm run start&'
                sh 'npm run cypress:run --headless chrome'
            }
        }
            
       
    }
}

    }
}       
       
    