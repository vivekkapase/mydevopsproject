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
                sh '
                cd tweet-trend
                mvn clean deploy'
            }
        }
    }
}
