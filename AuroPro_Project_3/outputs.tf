output "vpc_id" {
  value = module.my_vpc.vpc_id
}

output "public_subnet_id" {
  value = module.my_vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.my_vpc.private_subnet_id
}

output "public_ip" {
  value = module.my_instance.public_ip
}

output "private_ip" {
  value = module.my_instance.private_ip
}

# output "private_key_pem" {
#   value = module.my_instance.key_name
# }

# output "private_key_pem" {
#   value = module.my_instance.ssh_key.private_key_pem
# }

# output "private_key_pem" {
#   value = module.ssh_key.private_key_pem
# }

output "private_key_pem" {
  value = module.my_instance.private_key_pem
}
