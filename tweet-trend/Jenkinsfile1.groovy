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
                echo "Code is getting built....."
                cd tweet-trend
                mvn clean deploy
                echo "Code build completed. Proceeding to publish the artifact."
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
        def registry = 'https://vivekdevops.jfrog.io/'
        stage("Jar Artifact Publish over Jfrog") {
         steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"vivek-jfrog-token"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "tweet-trend/jarstaging/(*)",
                              "target": "vivek-maven-libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
            }
        }   
      }   
    }
}
