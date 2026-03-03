provider "aws" {
    region = var.my_region
}

resource "aws_instance" "my_ec2_instance" {
    ami           = var.my_ami_id
    instance_type = var.my_instance_type
    key_name = "aws_keypair"

    tags = {
        Name = "Web Server"
    }
}

