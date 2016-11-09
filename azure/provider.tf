# Configure the Azure Provider
provider "azure" {
  publish_settings = "${file("~/Work/Azure/Pay-As-You-Go-11-9-2016-credentials.publishsettings")  }"
}
