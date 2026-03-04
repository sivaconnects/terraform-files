
output "instance_ids" {
  value = aws_instance.web_server[*].id
}

output "instance_public_ips" {
  value = aws_instance.web_server[*].public_ip
}

output "instance_private_ips" {
  value = aws_instance.web_server[*].private_ip
}
