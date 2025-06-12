variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "Name of the AWS key pair"
  type        = string
  default     = "minecraft-key"
}

variable "allowed_cidr" {
  description = "CIDR block allowed to connect to Minecraft server"
  type        = string
  default     = "0.0.0.0/0"
}

variable "minecraft_port" {
  description = "Minecraft server port"
  type        = number
  default     = 25565
}