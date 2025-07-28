output "codepipeline_role_arn"    { value = aws_iam_role.codepipeline.arn }
output "codebuild_role_arn"       { value = aws_iam_role.codebuild.arn }
output "codedeploy_role_arn"      { value = aws_iam_role.codedeploy.arn }
output "codedeploy_instance_profile_name" {
  value = aws_iam_instance_profile.codedeploy_ec2_profile.name
}


