resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  tags = var.tags
}

resource "azurerm_virtual_machine" "main" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  vm_size               = var.vm_size
  network_interface_ids = [azurerm_network_interface.main.id]
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer_product
    sku       = var.sku_plan
    version   = var.image_version == null ? "latest" : var.image_version
  }

  plan {
    name      = var.sku_plan
    publisher = var.publisher
    product   = var.offer_product
  }

  storage_os_disk {
    name              = "${var.vm_name}-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "${var.vm_name}"
    admin_username = var.admin_username == null ? "devopsadmin" : var.admin_password
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = var.tags
}