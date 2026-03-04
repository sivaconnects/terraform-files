provider "aws" {
  region = var.my_region
}


resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.my_instance_type
  key_name               = var.my_key_pair_name
  count                  = var.instance_count
  subnet_id              = aws_subnet.main_public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
                #!/bin/bash
                apt-get update -y
                apt-get install -y nginx
                systemctl start nginx
                systemctl enable nginx
                echo "<html><body><h1>Welcome to Web Server ${count.index + 1} in ${var.my_region}!</h1></body></html>" > /var/www/html/index.html
            EOF

  tags = {
    Name = "Web_Server_${format("%02d", count.index + 1)}_${var.my_region}"
  }
}




resource "aws_security_group" "web_sg" {
  name        = "web_server_sg"
  description = "Allow HTTP and SSH traffic"

  vpc_id = aws_vpc.main_vpc.id

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


