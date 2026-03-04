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
