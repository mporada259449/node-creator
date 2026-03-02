data "aws_ami" "bastion_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
resource "aws_security_group" "runner_sg" {
  name        = "runner_sg"
  description = "Security group for runners host"
  vpc_id      = var.runner_vpc
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "ssh"
    cidr_blocks      = [var.bastion_ip]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "runner-host" {
  count = var.runners_count
  instance_type = var.runner_type
  ami = data.aws_ami.bastion_ami.id
  key_name = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.runner_sg.id]
  subnet_id = var.runner_subnet
  tags = {
    name = "runner"
  }
}