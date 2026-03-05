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

