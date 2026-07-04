pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/ayushsingh2207/backup-pipeline.git'
            }
        }

        stage('Build Backup Image') {
            steps {
                sh 'docker build -t backup-pipeline-image .'
            }
        }

        stage('Run Backup') {
    steps {
        sh '''
        docker create --name temp-backup-container backup-pipeline-image
        docker start -a temp-backup-container
        mkdir -p backups
        docker cp temp-backup-container:/data/backups/. ./backups
        docker rm temp-backup-container
        '''
    }
}

        stage('Verify Backup Integrity') {
            steps {
                sh '''
                cd backups
                LATEST_BACKUP=$(ls -t *.tar.gz | head -n 1)
                echo "Verifying: $LATEST_BACKUP"
                sha256sum -c "$LATEST_BACKUP.sha256"
                '''
            }
        }
    }
    post {
    failure {
        emailext (
            subject: "FAILED: Backup Pipeline - Build #${env.BUILD_NUMBER}",
            body: "The backup pipeline failed. Check console output at: ${env.BUILD_URL}console",
            to: 'ayushsingh9f19408@gmail.com'
        )
    }
}
}