variable "artifact_bucket_name" {}
variable "codepipeline_role_arn" {}
variable "codebuild_project_name" {}
variable "codedeploy_app_name" {}
variable "codedeploy_deployment_group_name" {}

variable "github_owner" {}
variable "github_repo" {}
variable "github_branch" {}
variable "github_oauth_token" {
  sensitive = true
}
