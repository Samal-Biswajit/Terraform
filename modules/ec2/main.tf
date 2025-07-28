resource "aws_instance" "cd_target" {
  ami                    = "ami-0150ccaf51ab55a51"         # Valid AMI for ap-south-1 (Mumbai)
  instance_type          = "t2.micro"
  subnet_id              = "subnet-08cd3b75f943c88c4"
  iam_instance_profile   = var.iam_instance_profile_name
  key_name               = var.ec2_key_pair_name           # ✅ Added Key Pair

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y ruby wget
              yum install -y httpd
              cd /home/ec2-user
              wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
              chmod +x ./install
              ./install auto
              systemctl start codedeploy-agent
              systemctl enable codedeploy-agent
              systemctl start httpd
              systemctl enable httpd
              EOF

  tags = {
    Name = var.ec2_tag_name_value
  }

  depends_on = [var.iam_instance_profile_name]
}

