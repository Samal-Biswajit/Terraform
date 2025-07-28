variable "aws_region" {
  description = "AWS region for all AWS resources"
  type        = string
  default     = "us-east-1"
}

variable "github_owner" {
  description = "GitHub repository owner (organization or user)"
  type        = string
}

variable "github_repo" {
  description = "Name of the GitHub repository"
  type        = string
}

variable "github_branch" {
  description = "Branch to track for CodePipeline"
  type        = string
  default     = "main"
}

variable "github_oauth_token" {
  description = "GitHub Personal Access Token for CodePipeline source integration"
  type        = string
  sensitive   = true
}

variable "artifact_bucket_name" {
  description = "Unique name for the S3 bucket to store CodePipeline artifacts"
  type        = string
}

variable "ec2_tag_name_value" {
  description = "Value of the EC2 'Name' tag for CodeDeploy deployment group targeting"
  type        = string
}
