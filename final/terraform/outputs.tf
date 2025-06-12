output "instance_public_ip" {
  description = "Public IP address of the Minecraft server"
  value       = aws_instance.minecraft_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the Minecraft server"
  value       = aws_instance.minecraft_server.public_dns
}

output "minecraft_server_address" {
  description = "Minecraft server connection address"
  value       = "${aws_instance.minecraft_server.public_ip}:${var.minecraft_port}"
}