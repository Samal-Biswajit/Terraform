################
# CodePipeline #
################
data "aws_iam_policy_document" "codepipeline_assume" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codepipeline" {
  name               = "codepipeline-role"
  assume_role_policy = data.aws_iam_policy_document.codepipeline_assume.json
}

resource "aws_iam_role_policy_attachment" "codepipeline_s3" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "codepipeline_codedeploy" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}

resource "aws_iam_role_policy_attachment" "codepipeline_codebuild" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

###############
# CodeBuild   #
###############
data "aws_iam_policy_document" "codebuild_assume" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild" {
  name               = "codebuild-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume.json
}

resource "aws_iam_role_policy_attachment" "codebuild_attach" {
  role       = aws_iam_role.codebuild.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # For demo simplicity. Use least-privilege in production!
}

################
# CodeDeploy   #
################
data "aws_iam_policy_document" "codedeploy_assume" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codedeploy" {
  name               = "codedeploy-role"
  assume_role_policy = data.aws_iam_policy_document.codedeploy_assume.json
}

resource "aws_iam_role_policy_attachment" "codedeploy_attach" {
  role       = aws_iam_role.codedeploy.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

####################################
# CodeDeploy EC2 Instance Profile  #
####################################
data "aws_iam_policy_document" "ec2_assume" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codedeploy_instance_role" {
  name               = "codedeploy-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}

resource "aws_iam_role_policy_attachment" "codedeploy_ec2_policy" {
  role       = aws_iam_role.codedeploy_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "ssm_managed_policy" {
  role       = aws_iam_role.codedeploy_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "codedeploy_ec2_profile" {
  name = "codedeploy-ec2-profile"
  role = aws_iam_role.codedeploy_instance_role.name
}
