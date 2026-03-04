
variable "my_region" {
  default = "eu-north-1"
}

variable "my_instance_type" {
  default = "t3.micro"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "my_key_pair_name" {
  description = "Name of the existing AWS Key Pair to use for EC2 instances"
  type        = string
  default     = "aws_keypair"
}
