# 🚀 AWS CodePipeline with Terraform (GitHub to EC2)

## 📌 Project Idea

Provision a complete CI/CD pipeline on AWS using *Terraform*. The pipeline includes:

- *Source*: GitHub repo (triggers on code push)
- *Build*: AWS CodeBuild compiles and packages the app
- *Deploy*: AWS CodeDeploy deploys to EC2 instance
- *Storage*: S3 bucket for storing build artifacts
- *Permissions*: IAM roles for CodePipeline, CodeBuild, and CodeDeploy

---

## 🔧 Key Features

- Fully automated pipeline setup using IaC
- GitHub → Build → Deploy to EC2 flow
- Modular Terraform code (infrastructure split by purpose)
- Supports deployment via appspec.yml and buildspec.yml