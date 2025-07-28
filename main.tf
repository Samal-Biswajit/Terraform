module "s3_artifact_bucket" {
  source              = "./modules/s3_artifact_bucket"
  artifact_bucket_name = var.artifact_bucket_name
}

module "ec2" {
  source              = "./modules/ec2"
  ec2_tag_name_value  = var.ec2_tag_name_value
  iam_instance_profile_name = module.iam.codedeploy_instance_profile_name
}

module "iam" {
  source              = "./modules/iam"
  artifact_bucket_arn = module.s3_artifact_bucket.artifact_bucket_arn
}

module "codebuild" {
  source                = "./modules/codebuild"
  codebuild_role_arn    = module.iam.codebuild_role_arn
}

module "codedeploy" {
  source                 = "./modules/codedeploy"
  codedeploy_role_arn    = module.iam.codedeploy_role_arn
  ec2_tag_name_value     = var.ec2_tag_name_value
}

module "codepipeline" {
  source = "./modules/codepipeline"

  artifact_bucket_name = module.s3_artifact_bucket.artifact_bucket_name
  codepipeline_role_arn = module.iam.codepipeline_role_arn
  codebuild_project_name = module.codebuild.codebuild_project_name
  codedeploy_app_name = module.codedeploy.codedeploy_app_name
  codedeploy_deployment_group_name = module.codedeploy.codedeploy_deployment_group_name

  github_owner         = var.github_owner
  github_repo          = var.github_repo
  github_branch        = var.github_branch
  github_oauth_token   = var.github_oauth_token
}
