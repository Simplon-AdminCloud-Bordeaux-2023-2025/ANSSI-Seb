# Create tls private key for admin user
resource "tls_private_key" "admin_rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "admin_rsa_file" {
  filename        = "../../${path.module}/ssh_keys/${local.admin_username}"
  file_permission = "0600"
  content         = tls_private_key.admin_rsa.private_key_openssh
}