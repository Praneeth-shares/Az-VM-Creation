resource "azurerm_network_interface" "main" {
  name                = "terraform-nic"
  location            = data.azurerm_resource_group.DemoRG.location
  resource_group_name = data.azurerm_resource_group.DemoRG.name

  ip_configuration {
    name                          = "terraformconfiguration1"
    subnet_id                     = data.azurerm_subnet.AZsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "devops" {
  name                = "devops-box"
  resource_group_name = data.azurerm_resource_group.DemoRG.name
  location            = data.azurerm_resource_group.DemoRG.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}