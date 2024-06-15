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
    //     stage('SonarQube analysis') {
    //     environment {
    //        scannerHome = tool 'vivek-sonar-scanner'
    //     }
    //     steps {
    //     sh '''JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/ && export JAVA_HOME'''
    //     withSonarQubeEnv('sonarqube-server') { // If you have configured more than one global server connection, you can specify its name
    //     sh '''
    //     cd tweet-trend
    //     ${scannerHome}/bin/sonar-scanner'''
    //     }
    //     }
        

    //   }
    
    }
}
