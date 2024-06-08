pipeline {
    agent {
        node{
            label 'build-slave'
        }
    }

    stages {
        stage('Git clone') {
            steps {
                git branch: 'main', url: 'https://github.com/ravdy/tweet-trend.git'
            }
        }
    }
}
