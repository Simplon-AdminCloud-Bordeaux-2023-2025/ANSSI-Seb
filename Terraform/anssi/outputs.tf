output "admin_ssh" {
  value = " ssh -i ${local_file.admin_rsa_file.filename} -p ${local.ssh_port} ${local.admin_username}@${module.vm.vm_fqdn} "
}

output "vm_fqdn" {
  value = " https://${module.vm.vm_fqdn} "
}