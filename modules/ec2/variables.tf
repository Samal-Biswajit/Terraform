variable "ec2_tag_name_value" {
  description = "Name tag for EC2 instance"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile to attach to EC2"
  type        = string
}

variable "ec2_key_pair_name" {
  description = "Name of the EC2 Key Pair to use for SSH"
  type        = string
}
