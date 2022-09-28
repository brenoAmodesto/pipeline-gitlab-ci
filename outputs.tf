output "vmazure_ip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "vmaws_ip" {
    value = aws_instance.vm.public_ip
}