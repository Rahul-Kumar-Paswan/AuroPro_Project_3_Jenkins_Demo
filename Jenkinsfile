#!/usr/bin/env groovy

library identifier : 'jenkins-shared-library@main',retriever:modernSCM([
    $class:'GitSCMSource',
    remote:'https://github.com/Rahul-Kumar-Paswan/flask-shared-lib.git',
    credentialsId:'git-credentials'
])

pipeline {
  agent any
  
  stages{

    stage('Increment Version') {
      steps {
        script {
          echo " hello dear"
          def currentVersion = sh(
            script: "python3 -c \"import re; match = re.search(r'version=\\\\'(.*?)\\\\'', open('setup.py').read()); print(match.group(1) if match else '143')\"",
              returnStdout: true
              ).trim()

          echo "Previous Version: ${currentVersion}"
          // Split the version into major, minor, and patch parts
          def versionParts = currentVersion.split('\\.')

          // Access the version parts using index
          def major = versionParts[0]
          def minor = versionParts[1]
          def patch = versionParts[2]

          echo "Current Version: ${currentVersion}"
          echo "Major: ${major}"
          echo "Minor: ${minor}"
          echo "Patch: ${patch}"
          echo "old versionParts : ${versionParts}"
                    
          // Increment the patch part
          versionParts[-1] = String.valueOf(versionParts[-1].toInteger() + 1)
          echo "new versionParts : ${versionParts}"
                    
          // Join the version parts back together
          def newVersion = versionParts.join('.')
          echo "newVersion : ${newVersion}"
                    
          // Update the setup.py file with the new version
          sh "sed -i \"s/version='${currentVersion}'/version='${newVersion}'/\" setup.py"

          echo "New Version: ${newVersion}"
          env.IMAGE_NAME = "$newVersion-$BUILD_NUMBER"
          echo "New IMAGE_NAME: ${IMAGE_NAME}"
        }
      }
    }

    stage('Clean Build Artifacts') {
      steps {
        echo " hello dear welcome to  my world !!!!"
        sh 'rm -rf build/ dist/ *.egg-info/'
        echo " hello dear welcome to  my world !!!!"
        sh 'git status'
      }
    }
    
    stage('Build Image') {
      steps {
        echo "hello"
        buildImage "flask_app_project3:${IMAGE_NAME}"
        dockerLogin()
        dockerPush "flask_app_project3:${IMAGE_NAME}"
      }
    }

    stage('Provision Server') {
      environment {
        AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key')
        AWS_ACCESS_KEY_KEY = credentials('jenkins_aws_access_secret')
        TF_VAR_env_prefix = 'test'
      }
      steps {
        script {
          dir('AuroPro_Project_3'){
            sh "terraform init"
            sh "terraform apply -auto-approve"
            EC2_PUBLIC_IP = sh(
              script: "terraform output public_ip",
              returnStdout:true
            ).trim()
          }
        }
      }
    }

    stage('Deploy with Docker Compose and Groovy') {
      steps {
        script {
          echo "Deploy to LOCALHOST........"
          def dockerCmd = "docker-compose up -d"
          echo "${EC2_PUBLIC_IP}"

          PEM_FILE = sh(
            script: "terraform output private_key",
            returnStdout:false
          )

          def ec2Instance = "ec2-user@${EC2_PUBLIC_IP}"
          /* sshagent(['ec2-server-key']){
            sh "ssh -o StrictHostKeyChecking=no ${EC2_PUBLIC_IP} ${dockerCmd}"//add ip address of EC2-docker instance 
          } */

           // Run your SSH commands using the private key
          sh "ssh -o StrictHostKeyChecking=no -i ${PEM_FILE} ${ec2Instance} ${dockerCmd}"

          // deployApp "flask_app_project3:${IMAGE_NAME}"
          echo "Deploying new image........ "
        }
      }
    }


  }
}
