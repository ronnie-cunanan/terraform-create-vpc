pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'prod'],
            description: 'Select the environment to deploy'
        )
    }

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

        stage('Select Environment') {
            steps {
                script {
                    echo "🌍 Selected environment: ${ENVIRONMENT}"

                    // Build path to tfvars file
                    env.TFVARS_FILE = "env/${ENVIRONMENT}.tfvars"

                    // Validate file exists
                    if (!fileExists(env.TFVARS_FILE)) {
                        error "❌ Missing ${env.TFVARS_FILE} — cannot continue"
                    }

                    echo "📄 Using tfvars file: ${env.TFVARS_FILE}"
                }
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
                    echo "📘 Running Terraform Plan for ${ENVIRONMENT}..."

                    def planStatus = sh(
                        script: "terraform plan -input=false -var-file=${TFVARS_FILE} -out=tfplan",
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

        stage('Terraform Apply') {
            when {
                expression { return ENVIRONMENT == 'prod' }
            }
            steps {
                script {
                    echo "🚀 Running Terraform Apply for PROD..."

                    def applyStatus = sh(
                        script: "terraform apply -input=false -auto-approve tfplan",
                        returnStatus: true
                    )

                    if (applyStatus == 0) {
                        echo "🎉 Terraform Apply Successful — PROD Infrastructure Deployed"
                    } else {
                        echo "❌ Terraform Apply Failed"
                        error("Stopping pipeline because Terraform Apply failed")
                    }
                }
            }
        }
        /*
        stage('Terraform Apply (Dev)') {
            when {
                expression { return ENVIRONMENT == 'dev' }
            }
            steps {
                script {
                    echo "🚀 Running Terraform Apply for DEV..."

                    def applyStatus = sh(
                        script: "terraform apply -input=false -auto-approve tfplan",
                        returnStatus: true
                    )

                    if (applyStatus == 0) {
                        echo "🎉 Terraform Apply Successful — DEV Infrastructure Deployed"
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
