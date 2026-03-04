provider "aws" {
    region = var.my_region
}


resource "aws_instance" "web_server" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = var.my_instance_type
    key_name = "aws_keypair"
    count         = var.instance_count

    tags = {
        Name = "Web_Server_${format("%02d", count.index + 1)}_${var.my_region}"
    }
}


