provider "aws" {
    region = "eu-north-1"
}

resource "aws_s3_bucket" "my-first-s3-bucket" {
    bucket = "kanishetty-my-unique-first-s3-bucket-2026"
}
