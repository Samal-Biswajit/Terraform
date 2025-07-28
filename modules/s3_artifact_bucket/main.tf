resource "aws_s3_bucket" "artifact" {
  bucket        = var.artifact_bucket_name
  force_destroy = true

  lifecycle {
    prevent_destroy = true
  }
}