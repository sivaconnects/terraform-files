provider "aws" {
  region = var.my_region
}


resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.my_instance_type
  key_name               = "aws_keypair"
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "Web_Server_${format("%02d", count.index + 1)}_${var.my_region}"
  }
}



resource "aws_security_group" "web_sg" {
  name        = "web_server_sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web_SG_${var.my_region}"
  }

}


