output "instance_id" {
  value = aws_instance.my_instance.id
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "private_ip" {
  value = aws_instance.my_instance.private_ip
}

output "my_security_group_id" {
  value = aws_security_group.my_security_group.id
}

output "private_key_pem" {
  value       = aws_key_pair.ssh-key.key_name
  sensitive   = true
  description = "Private key for the SSH key pair"
}

