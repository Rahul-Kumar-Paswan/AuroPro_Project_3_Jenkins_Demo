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
  value = module.aws_instance.my_instance.public_ip
}

output "private_ip" {
  value = module.aws_instance.my_instance.private_ip
}