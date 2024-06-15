pipeline {
    agent {
        node{
            label 'build-slave'
        }
    }
environment {
    PATH = "/opt/apache-maven-3.9.7/bin/:$PATH"
}

    stages {
        stage('Build code') {
            steps {
                sh '''
                cd tweet-trend
                mvn clean deploy
                '''
            
            }
        }
        stage('SonarQube analysis') {
        tools {
        jdk "vivek-jdk" // the name you have given the JDK installation in Global Tool Configuration
         }
        environment {
           scannerHome = tool 'vivek-sonar-scanner'
        }
        steps {
        withSonarQubeEnv('sonarqube-server') { // If you have configured more than one global server connection, you can specify its name
        sh "${scannerHome}/bin/sonar-scanner -X"
        }
        }
        

      }
    }
}
