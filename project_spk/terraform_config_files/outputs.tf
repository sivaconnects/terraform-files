output "public_instance_ips" {
  value       = aws_instance.my_public_instance.*.public_ip
  description = "Public IP addresses of the created instances."
}

output "private_instance_ips" {
  value       = aws_instance.my_private_instance.*.private_ip
  description = "Private IP addresses of the created instances."
}

output "instance_ids" {
  value       = aws_instance.my_public_instance.*.id
  description = "IDs of the created instances."
}

