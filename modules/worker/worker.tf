data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "worker" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.worker_sg.id]
  key_name               = var.worker_appserv_key_name
  user_data              = file("modules/worker/user_data_worker.sh")
  tags = {
    Name = "worker--${var.env}"
  }
  depends_on = [aws_key_pair.generated_key]
}
resource "aws_security_group" "worker_sg" {
  name = "worker security group ${var.env}"
  dynamic "ingress" {
    for_each = ["50000", "22"]
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
    Name = "worker security group -${var.env}"
  }
}
