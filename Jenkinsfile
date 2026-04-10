pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "ap-southeast-2"
        AWS_CREDS = credentials('aws-jenkins-creds')
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/ronnie-cunanan/terraform-create-vpc.git'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    echo "🔧 Running Terraform Init..."

                    def initStatus = sh(
                        script: "terraform init -input=false",
                        returnStatus: true
                    )

                    if (initStatus == 0) {
                        echo "✅ Terraform Init Successful"
                    } else {
                        echo "❌ Terraform Init Failed"
                        error("Stopping pipeline because Terraform Init failed")
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    echo "📘 Running Terraform Plan..."

                    def planStatus = sh(
                        script: "terraform plan -input=false -var-file=env/dev.tfvars -out=tfplan",
                        returnStatus: true
                    )

                    if (planStatus == 0) {
                        echo "✅ Terraform Plan Successful"
                    } else {
                        echo "❌ Terraform Plan Failed"
                        error("Stopping pipeline because Terraform Plan failed")
                    }
                }
            }
        }
        /*
        stage('Terraform Apply') {
            steps {
                script {
                    echo "🚀 Running Terraform Apply..."

                    def applyStatus = sh(
                        script: "terraform apply -input=false -auto-approve tfplan",
                        returnStatus: true
                    )

                    if (applyStatus == 0) {
                        echo "🎉 Terraform Apply Successful — Infrastructure Deployed"
                    } else {
                        echo "❌ Terraform Apply Failed"
                        error("Stopping pipeline because Terraform Apply failed")
                    }
                }
            }
        }
        */
    }

    post {
        always {
            echo "🧹 Cleaning workspace..."
            cleanWs()
        }
    }
}
