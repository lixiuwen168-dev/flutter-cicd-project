pipeline {
    agent any

    stages {
        stage('Pull Code') {
            steps {
                echo '📥 Code pulled from GitHub!'
                sh 'ls -la'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🔨 Building Docker image...'
                sh 'docker build -t github-demo:latest .'
                echo '✅ Image built!'
            }
        }

        stage('Run Container') {
            steps {
                echo '🚀 Running container...'
                sh 'docker run --rm github-demo:latest'
                echo '✅ Container ran successfully!'
            }
        }

        stage('Cleanup') {
            steps {
                echo '🧹 Cleaning up...'
                sh 'docker rmi github-demo:latest || true'
                echo '✅ Done!'
            }
        }
    }

    post {
        success {
            echo '🎉 Pipeline SUCCESS!'
        }
        failure {
            echo '❌ Pipeline FAILED!'
        }
    }
}
