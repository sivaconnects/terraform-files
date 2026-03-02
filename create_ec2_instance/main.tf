terraform {
    required_version = ">= 0.13"
    
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
        }
    }
}
provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "web" {
    ami           = "ami-073130f74f5ffb161"
    instance_type = "t3.micro"

    tags = {
        Name = "WebServer"
    }
}



