output "vpc_id" {
  value = module.my_vpc.vpc_id
}

output "public_subnet_id" {
  value = module.my_vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.my_vpc.private_subnet_id
}
