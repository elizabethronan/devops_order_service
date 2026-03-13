@Library('jenkins-shared-library') _

pipeline {
    agent any

    environment {
        IMAGE_NAME    = "eronan22/order-service"
        IMAGE_TAG     = "git-${GIT_COMMIT[0..7]}"
    }

    stages {

        stage('PR Validation') {
            when {
                changeRequest()
            }
            steps {
                echo 'Running PR validation - build and test only, no deployment'
                sh 'npm install'
                sh 'npm test -- --watchAll=false --passWithNoTests'
            }
        }

        stage('Build') {
            steps {
                echo 'Installing dependencies...'
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'npm test -- --watchAll=false --passWithNoTests'
            }
        }

        stage('Source Security Scan') {
            steps {
                securityScan('.', 'fs')
            }
        }

        stage('Container Build & Push') {
            when {
                anyOf {
                    branch 'develop'
                    branch 'main'
                }
            }
            steps {
                buildAndPush(IMAGE_NAME, IMAGE_TAG, 'dockerhub-credentials')
            }
        }

        stage('Container Security Scan') {
            when {
                anyOf {
                    branch 'develop'
                    branch 'main'
                }
            }
            steps {
                securityScan("${IMAGE_NAME}:${IMAGE_TAG}", 'image')
            }
        }

        stage('Deploy to Staging') {
            when { branch 'release/*'}
            steps {
                deployToK8s('order-service', IMAGE_NAME, IMAGE_TAG, 'staging')
            }
        }

        stage('Deploy to Dev') {
            when { branch 'develop' }
            steps {
                deployToK8s('order-service', IMAGE_NAME, IMAGE_TAG, 'dev')
            }
        }

        stage('Deploy to Production') {
            when { branch 'main' }
            steps {
                input message: 'Deploy to production?', ok: 'Approve'
                deployToK8s('order-service', IMAGE_NAME, IMAGE_TAG, 'prod')
            }
        }

    }

    post {
        success {
            echo "Order service pipeline completed - ${IMAGE_NAME}:${IMAGE_TAG}"
        }
        failure {
            echo "Order service pipeline failed"
        }
        always {
            sh 'docker logout'
        }
    }
}