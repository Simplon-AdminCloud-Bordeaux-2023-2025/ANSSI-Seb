resource "null_resource" "playbookconfig" {
  depends_on = [module.vm]
  provisioner "local-exec" {
    working_dir = "${path.root}/../../Ansible"
    interpreter = ["bash", "-c"]
    command     = "sleep 100; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook install-appli.yml -i inventaire.ini"
  }
}