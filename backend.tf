terraform {
  backend "s3" {
    bucket         = "my-pipeline-artifacts-bucket"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks" # optional but recommended
    encrypt        = true
  }
}
