resource "null_resource" "playbookconfig" {
  depends_on = [module.vm]
  provisioner "local-exec" {
    working_dir = "${path.root}/../../Ansible"
    interpreter = ["bash", "-c"]
    command     = "ansible-galaxy install -r requirements.yml -p roles/ --force"
    command     = "sleep 100; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook install-appli.yml -i inventaire.ini"
  }
}