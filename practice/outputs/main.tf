provider "aws" {
    region = var.my_region
}

resource "aws_instance" "web_server" {
    ami           = var.my_ami_id
    instance_type = var.my_instance_type
    key_name = "aws_keypair"

    tags = {
        Name = "Web Server"
    }
}

