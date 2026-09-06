	pipeline {
    agent any
    
    tools {
        maven 'Maven'
    }
    environment {
        DOCKER_HOST = 'unix:///var/run/docker.sock'
        REGISTRY_CREDENTIALS = 'youtube-cred'  // ID from Jenkins credentials
        DOCKER_IMAGE = 'luniva6/spring-app'
        DOCKER_TAG = 'latest'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'staging', url: 'https://github.com/shr1luni/Wars.git'
            }
        }
        stage('Build') {
            steps {
                sh 'ls -la'
                sh 'mvn clean install -DskipTests -Djacoco.skip=true -Dmaven.test.skip=true'            }
        }
        stage('Build Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'youtube-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                  sh "docker build -t luniva6/spring-app:${BUILD_NUMBER} ."
                  sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                  sh "docker push luniva6/spring-app:${BUILD_NUMBER}"
                }

                // script {
                //     dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                // }
            }
        }

    }
}
