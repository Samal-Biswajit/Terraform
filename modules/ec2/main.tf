resource "aws_instance" "cd_target" {
  ami = "ami-0f5ee92e2d63afc18" # Ubuntu Server 22.04 LTS (ap-south-1)
  instance_type          = "t2.micro"
  subnet_id              = "subnet-0def79427f0d225af"
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

