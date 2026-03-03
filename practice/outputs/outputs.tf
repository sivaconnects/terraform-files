output "my_server_public_ip" {
    description = "The public IP address of the EC2 instance."
    value       = aws_instance.my_ec2_instance.public_ip
}

output "my_server_private_ip" {
    description = "The private IP address of the EC2 instance."
    value       = aws_instance.my_ec2_instance.private_ip
}


