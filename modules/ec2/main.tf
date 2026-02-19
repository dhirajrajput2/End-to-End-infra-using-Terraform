resource "aws_launch_template" "lt" {
  name_prefix   = "project1-lt"
  image_id      = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.security_group_id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
dnf install -y nginx
systemctl start nginx
systemctl enable nginx
EOF
  )
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
}
