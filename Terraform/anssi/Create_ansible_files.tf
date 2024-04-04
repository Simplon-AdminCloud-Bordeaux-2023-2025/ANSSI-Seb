# Create inventaire.ini for Ansible

resource "local_file" "inventaire" {
  filename        = "${path.module}/../../Ansible/inventaire.ini"
  file_permission = "0644"
  content         = <<-EOT
[appli]
${module.vm.vm_fqdn}

[appli:vars]
ansible_port=${local.ssh_port}
ansible_ssh_private_key_file="../ssh_keys/${basename(local_file.admin_rsa_file.filename)}"

[all:vars]
ansible_connection=ssh
ansible_ssh_user=${local.admin_username}
ansible_become=true
ansible_python_interpreter="/usr/bin/python3"
EOT

  depends_on = [
    local_file.admin_rsa_file
  ]
}