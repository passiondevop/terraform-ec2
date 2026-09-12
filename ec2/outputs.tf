output "instance_ids" {
  value = module.ec2_vms.instance_ids
}

output "public_ips" {
  value = module.ec2_vms.public_ips
}

output "private_ips" {
  value = module.ec2_vms.private_ips
}
