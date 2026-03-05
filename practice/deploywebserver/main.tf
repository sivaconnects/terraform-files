variable "my_region" {
    description = "The region where resources will be created."
    type        = string
    default     = "eu-north-1"
}

variable "my_instance_type" {
    description = "The type of instance to create."
    type        = string
    default     = "t3.micro"
}

variable "my_instance_count" {
    description = "The number of instances to create."
    type        = number
    default     = 1
}

variable "my_keypair" {
    description = "The name of the key pair to use for SSH access."
    type        = string
    default     = "aws_keypair"
}


data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"] # Canonical
}

data "aws_availability_zones" "available" {
    state = "available"
}


resource "aws_vpc" "main_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Main_VPC_${var.my_region}"
    }
}

resource "aws_subnet" "main_public_subnet" {
    vpc_id            = aws_vpc.main_vpc.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    tags = {
        Name = "Main_Public_Subnet_${var.my_region}"
    }
}

resource "aws_subnet" "main_private_subnet" {
    vpc_id            = aws_vpc.main_vpc.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = data.aws_availability_zones.available.names[0]
    tags = {
        Name = "Main_Private_Subnet_${var.my_region}"
    }
}

resource "aws_internet_gateway" "main_igw" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "Main_IGW_${var.my_region}"
    }
}

resource "aws_route_table" "main_public_rt" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_igw.id
    }
    tags = {
        Name = "Main_Public_RT_${var.my_region}"
    }
}

resource "aws_route_table_association" "main_public_rt_assoc" {
    subnet_id      = aws_subnet.main_public_subnet.id
    route_table_id = aws_route_table.main_public_rt.id
}


resource "aws_security_group" "main_sg" {
    name        = "Main_SG_${var.my_region}"
    description = "Security group for main VPC"
    vpc_id      = aws_vpc.main_vpc.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group_rule" "allow_ssh" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.main_sg.id    
}

provider "aws" {
    region = var.my_region
}

resource "aws_instance" "my_public_instance" {
    count         = var.my_instance_count
    ami           = data.aws_ami.ubuntu.id
    instance_type  = var.my_instance_type
    subnet_id      = aws_subnet.main_public_subnet.id
    key_name       = var.my_keypair
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
    count         = var.my_instance_count
    ami           = data.aws_ami.ubuntu.id
    instance_type  = var.my_instance_type
    subnet_id      = aws_subnet.main_private_subnet.id
    key_name       = var.my_keypair
    vpc_security_group_ids = [aws_security_group.main_sg.id]
    tags = {
        Name = "Private_Instance_${count.index + 1}_${var.my_region}"
    }
}


output "public_instance_ips" {
    value = aws_instance.my_public_instance.*.public_ip
    description = "Public IP addresses of the created instances."
}

output "private_instance_ips" {
    value = aws_instance.my_private_instance.*.private_ip
    description = "Private IP addresses of the created instances."
}

output "instance_ids" {
    value = aws_instance.my_public_instance.*.id
    description = "IDs of the created instances."
}


