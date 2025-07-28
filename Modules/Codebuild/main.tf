resource "aws_codebuild_project" "main" {
  name          = "pipeline-codebuild-project"
  description   = "Project for CodePipeline"
  build_timeout = 20
  service_role  = var.codebuild_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:6.0"
    type         = "LINUX_CONTAINER"
  }

  source {
    type     = "CODEPIPELINE"
    buildspec = file("${path.module}/buildspec.yml")
  }
}
