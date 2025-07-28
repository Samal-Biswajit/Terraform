terraform {
  backend "s3" {
    bucket         = "my-artifact-bucket-biswajit"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}
