resource "azurerm_virtual_network" "devopsdenvermcvnet" {
    name = "devopsdenvermcvnet0"
    address_space = ["10.0.0.0/16"]
    location = "${var.location}"
    resource_group_name = "${var.resource_group}"
}

resource "azurerm_subnet" "devopsdenvermcsubnet" {
    name = "subnet1"
    resource_group_name = "${var.resource_group}"
    virtual_network_name = "${azurerm_virtual_network.devopsdenvermcvnet.name}"
    address_prefix = "10.0.2.0/24"
}

resource "azurerm_network_interface" "devopsdenvermcnic" {
    name = "nic1"
    location = "${var.location}"
    resource_group_name = "${var.resource_group}"

    ip_configuration {
        name = "ipconfig"
        subnet_id = "${azurerm_subnet.devopsdenvermcsubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_virtual_machine" "winserver" {
    name = "windowsserver2012"
    location = "${var.location}"
    resource_group_name = "${var.resource_group}"
    network_interface_ids = ["${azurerm_network_interface.devopsdenvermcnic.id}"]
    vm_size = "Standard_A0"

    storage_os_disk {
        name = "myosdisk1"
        vhd_uri = "https://pkdenverdevopsmcstorage.blob.core.windows.net/den-devops-mc-win2012r2/disk-1.vhd"
        os_type = "windows"
        caching = "ReadWrite"
        create_option = "FromImage"
    }
}
