resource "azure_virtual_network" "vnet" {
    name = "devopsdenmctf-network"
    address_space = ["10.1.2.0/24"]
    location = "East US"

    subnet {
        name = "subnet1"
        address_prefix = "10.1.2.0/25"
    }
}

resource "azure_security_group" "websg" {
    name = "webservers"
    location = "East US"
}

resource "azure_security_group_rule" "ssh_access" {
    name = "ssh-access-rule"
    security_group_names = ["${azure_security_group.websg.name}"]
    type = "Inbound"
    action = "Allow"
    priority = 200
    source_address_prefix = "72.25.157.196/32"
    source_port_range = "*"
    destination_address_prefix = "*"
    destination_port_range = "22"
    protocol = "TCP"
}

resource "azure_security_group_rule" "ingress_http_outbound" {
    name = "ingress_node-inbound-access-rule"
    security_group_names = ["${azure_security_group.websg.name}"]
    type = "Outbound"
    action = "Allow"
    priority = 201
    source_address_prefix = "*"
    source_port_range = "*"
    destination_address_prefix = "*"
    destination_port_range = "*"
    protocol = "TCP"
}

resource "azure_hosted_service" "terraform-service" {
    name = "pkdenverdevopsmc-tf-service"
    location = "East US"
    ephemeral_contents = true
    provisioner "local-exec" {
     command = "azure service cert create ${self.name} ${var.azure_ssh_key_path}"
    }
    description = "Hosted service created by Terraform."
    label = "den-devops-mcheriyath-tf"
}

resource "azure_instance" "web" {
    name = "terraform-azure-test"
    description = "Web Server launched using terraform"
    hosted_service_name = "${azure_hosted_service.terraform-service.name}"
    image = "Ubuntu Server 14.04 LTS"
    size = "Basic_A1"
    storage_service_name = "pkdenverdevopsmcstorage"
    location = "East US"
    username = "terraform"
    subnet = "subnet1"
    virtual_network = "devopsdenmctf-network"
    security_group = "webservers"
    ssh_key_thumbprint = "${var.azure_ssh_key_fingerprint}"
    endpoint {
        name = "SSH"
        protocol = "tcp"
        public_port = 22
        private_port = 22
    }
    endpoint {
        name = "WEB"
        protocol = "tcp"
        public_port = 80
        private_port = 80
    }
    provisioner "file" {
        source = "script.sh"
        destination = "/tmp/script.sh"
    }
    provisioner "remote-exec" {
        inline = ["bash /tmp/script.sh"]
    }
}
