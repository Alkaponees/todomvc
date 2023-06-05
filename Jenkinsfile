pipeline {
    environment {
    GITHUB_TOKEN=credentials('github-token')
    IMAGE_NAME='ghcr.io/alkaponees/todomvc'
  }
   agent any
    stages {
        stage('Get Version') {
            steps {
                script {
                    VERSION = input(
                        id: 'versionInput',
                        message: 'Enter the next version of package:',
                        parameters: [
                            string(name: 'VERSION', defaultValue: 'latest', description: 'Version')
                        ]
                    )
                }
            }
        }
        stage('Work with Docker agent on node image'){
            // when {
            //     changeset 'origin/dev'
            //     }
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
                 sh 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
                    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
                    && apt-get update \
                    && apt-get install -y google-chrome-stable'    
                sh 'npm install'
                sh 'npm install cypress'
            }
            }
        stage('Test'){
            steps{
                sh 'npm run build'
                sh 'npm run start&'
                sh 'npm run cypress:run --headless chrome'
            }
        }
        }
        }
        stage ('Build')
        {
            steps{
                sh 'docker build -t $IMAGE_NAME:$VERSION .'
            }
        }    
    stage('push') {
      steps {
        sh 'echo $GITHUB_TOKEN_PSW | docker login ghcr.io -u $GITHUB_TOKEN_USR --password-stdin'
        sh 'docker push $IMAGE_NAME:$VERSION'
      }
    }
    stage ('Deploy')
    {
       agent {
                node {
                    label 'kuber'
                }
            }
        steps{
            sh 'rm -rf todomvc && git clone https://github.com/Alkaponees/todomvc.git'
            sh 'cd todomvc'
            sh 'minikube start --disk-size 10g --extra-config=apiserver.service-node-port-range=80-32767'
            sh 'kubectl apply -f k8s/ '
        }
    }
    }
}
    