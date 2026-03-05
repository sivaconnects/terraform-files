resource "aws_instance" "my_public_instance" {
  count                  = var.my_instance_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.my_instance_type
  subnet_id              = aws_subnet.main_public_subnet.id
  key_name               = var.my_keypair
  vpc_security_group_ids = [aws_security_group.main_sg.id]

  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install -y nginx
                sudo systemctl start nginx
                sudo systemctl enable nginx
                echo "Hello from Public Instance ${count.index + 1} in ${var.my_region}" > /var/www/html/index.html
                EOF
  tags = {
    Name = "Public_Instance_${count.index + 1}_${var.my_region}"
  }
}

resource "aws_instance" "my_private_instance" {
  count                  = var.my_instance_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.my_instance_type
  subnet_id              = aws_subnet.main_private_subnet.id
  key_name               = var.my_keypair
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  tags = {
    Name = "Private_Instance_${count.index + 1}_${var.my_region}"
  }
}

