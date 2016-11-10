output "azure-windows-vips" {
value = "${join(",", azure_instance.windows2012.*.vip_address)}"
}
