pipeline {
    agent any
    node {
    def workspace = pwd()
    }
    stages {
    stage ('Pre-task') {
        
    
    steps {
    
    withCredentials([
        string(credentialsId: 'AWS_CLI_ACCESS_KEY', variable: 'AWS_CLI_KEY_ID'), 
        string(credentialsId: 'AWS_CLI_ACCESS_KEY_SECRET', variable: 'AWS_CLI_KEY_SECRET')]) 
    {
    sh '''
    cd ${workspace}/terraform
    pwd
    terraform init
    '''
    }

      }
     }
    }
}