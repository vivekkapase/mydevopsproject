pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_CLI_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_CLI_ACCESS_KEY_SECRET')
    }
    stages {
    stage ('Pre-task') {
        
    
    steps {
    
    // withCredentials([
    //     string(credentialsId: 'AWS_CLI_ACCESS_KEY', variable: 'AWS_CLI_KEY_ID'), 
    //     string(credentialsId: 'AWS_CLI_ACCESS_KEY_SECRET', variable: 'AWS_CLI_KEY_SECRET')]) 
    
    sh '''
    cd terraform
    pwd
    terraform init 
    terraform validate
    terraform plan --var="access_key=$AWS_ACCESS_KEY_ID" --var="secret_key=$AWS_SECRET_ACCESS_KEY"
    '''
    

      }
     }
    stage ("CleanupWS")
    {
        cleanWS()
    }
    }
}