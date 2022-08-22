data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "template_file" "user_data_master" {
  template = templatefile("modules/jenkins/user_data_master.tftpl", {
    j_login              = var.jenkins_login,
    j_pass               = var.jenkins_pass,
    dh_login             = var.docker_hub_login,
    dh_pass              = var.docker_hub_password,
    dh_repo              = var.docker_hub_repo,
    gh_token             = var.git_hub_token,
    gh_app_repo          = var.git_hub_repo_app,
    gh_pipeline_repo     = var.git_hub_repo_pipeline,
    w_user               = var.worker_user,
    w_key                = var.worker_key,
    app_server_public_ip = var.app_server_public_ip,
    worker_ip            = var.worker_public_ip
  })
}

resource "aws_security_group" "jenkins_sg" {
  name = "jenkins security group ${var.env}"
  dynamic "ingress" {
    for_each = ["50000", "8080", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkins security group"
  }
}

resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = var.jenkins_key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  user_data              = data.template_file.user_data_master.rendered
  tags = {
    Name = "jenkins master ${var.env}"
  }
}
