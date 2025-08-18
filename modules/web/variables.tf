variable "project_name" { type = string }
variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "web_instance_type" { type = string }
variable "key_name" { type = string }
variable "allow_ssh_cidr" { type = string }
variable "tags" { type = map(string) }