# Create Cloud Service
resource "azure_hosted_service" "terraform-azure-service" {
  name = "pkdenverdevopsmc-tf-service"
  location = "East US"
  ephemeral_contents = true
  description = "cloudservice created for Azure using terraform"
  label = "den-devops-mcheriyath-tf"
}
 
# Create Azure Virtual Network (vNet)
resource "azure_virtual_network" "vnet" {
  name = "vNet01"
  address_space = ["10.1.2.0/24"]
  location = "East US"
  subnet {
        name = "subnet1"
        address_prefix = "10.1.2.0/25"
  }
}
 
# Create Azure Virtual Machine Instance
resource "azure_instance" "windows2012" {
  name = "${format("web%02d", count.index + 1)}"
  hosted_service_name = "${azure_hosted_service.terraform-azure-service.name}"
  image = "Windows Server 2012 R2 Datacenter, January 2016"
  size = "Basic_A1"
  storage_service_name = "pkdenverdevopsmcstorage"
  location = "East US"
  username = "terraform"
  password = "Pr0k@rma"
  virtual_network = "${azure_virtual_network.vnet.name}"
  subnet = "subnet1"
  time_zone = "America/New_York"
  count = "${var.server_count}"
 
endpoint {
  name = "RDP"
  protocol = "tcp"
  public_port = 3389
  private_port = 3389
 }
}
