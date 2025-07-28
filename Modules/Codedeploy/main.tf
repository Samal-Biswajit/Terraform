resource "aws_codedeploy_app" "main" {
  name             = "pipeline-codedeploy-app"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "main" {
  app_name              = aws_codedeploy_app.main.name
  deployment_group_name = "pipeline-codedeploy-dg"
  service_role_arn      = var.codedeploy_role_arn

  deployment_style {
    deployment_type   = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = var.ec2_tag_name_value
    }
  }
}
