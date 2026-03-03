variable "my_instance_type" {
    description = "The type of instance to use for the EC2 instance."
    type        = string
    default     = "t3.micro"
}

variable "my_region" {
    description = "The AWS region to deploy the EC2 instance."
    type        = string
    default     = "eu-north-1"
}

variable "my_ami_id" {
    description = "The AMI ID to use for the EC2 instance."
    type        = string
    default     = "ami-073130f74f5ffb161"
}
