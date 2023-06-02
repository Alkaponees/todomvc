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
                image 'node:14-alpine'
                args '-u root'
            }
        }
        stages{
            stage('Install '){
                steps {\
                sh 'apk update && apk add xvfb'
                sh 'npm install'
                sh 'npm install cypress'
              
            }
            }
        
        stage('Test'){
            steps{
                sh 'npm run build'
                
                sh 'npm run start&'
                sh 'npm run cypress:run '
            }
        }
            
        }
        
        }
        stage ('Build')
        {
            steps{
                sh 'docker build -t $IMAGE_NAME:$IMAGE_VERSION .'
            }
        }    
        stage('Push') {
      steps {
        sh 'echo $GITHUB_TOKEN_PSW | docker login ghcr.io -u $GITHUB_TOKEN_USR --password-stdin'
        sh 'docker push $IMAGE_NAME:$IMAGE_VERSION'
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
            sh 'minikube delete'
            sh 'minikube start --disk-size 10g --extra-config=apiserver.service-node-port-range=80-32767'
            sh 'kubectl apply -f k8s/ '
        }
    }
    }
}
        
       
    