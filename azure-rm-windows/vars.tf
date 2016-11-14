variable "subscriptionid" {}
variable "clientid" {}
variable "clientsecret" {}
variable "tenantid" {}
variable "resource_group" {
	type = "string"
	description = "Resource Group"
	default = "devopsdenvermcresourcegroup"
}
variable "storage_account" {
	type = "string"
	description = "Storage Account"
	default = "pkdevopsdenvermcstorage"
}
variable "location" {
	type = "string"
	description = "Location"
	default = "East US"
}
