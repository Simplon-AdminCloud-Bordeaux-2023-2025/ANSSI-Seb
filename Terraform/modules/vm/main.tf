resource "azurerm_public_ip" "main" {
  name                = "${var.application_name}-vm-ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = var.public_ip_allocation_method
  domain_name_label   = var.domain_name_label
  sku                 = var.public_ip_sku
}

resource "azurerm_network_interface" "main" {
  name                = "${var.application_name}-vm-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "${var.application_name}-vm-ip-config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.application_name}-vm-nsg"
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Règle de sécurité pour le port (SSH) depuis n'importe quelle source sur la VM
resource "azurerm_network_security_rule" "ssh" {
  name                        = "Allow-SSH-Inbound"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = var.ssh_port
  source_address_prefixes     = var.ssh_ip_filter
  destination_address_prefix  = azurerm_network_interface.main.private_ip_address
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_virtual_machine" "main" {
  name                          = "${var.application_name}-vm"
  location                      = var.location
  resource_group_name           = var.resource_group
  network_interface_ids         = [azurerm_network_interface.main.id]
  vm_size                       = var.vm_size
  delete_os_disk_on_termination = true


  storage_os_disk {
    name              = "${var.application_name}-vm"
    caching           = var.os_disk_caching
    create_option     = var.os_disk_create_option
    managed_disk_type = var.os_disk_managed_disk_type
  }

  #  RedHat:RHEL:8_8:8.8.2023310512
  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8_8"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${replace(var.application_name, "_", "")}-vm"
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = var.path
      key_data = var.ssh_key
    }
  }
  
}