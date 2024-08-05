output "IP_ZABBIX_SERVER_AWS" {
  description = "Ip vm zabbix server AWS"
  value       = aws_instance.vm.public_ip
}
output "IP_ZABBIX_AGENT_AZURE" {
  description = "Ip vm zabbix agent azure"
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "URL_ZABBIX_SERVER_AWS" {
  description = "Ip vm zabbix server AWS"
  value       = "http://${aws_instance.vm.public_ip}/zabbix"
}