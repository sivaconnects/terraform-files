# creating ec2 instance with aws_keypair

provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "my-first-ec2-instance" {
    ami = "ami-073130f74f5ffb161"
    instance_type = "t3.micro"
    key_name = "aws_keypair"
}
