variable "instance_count" {
  type    = number
  default = 2
}

variable "ami_id" {
  type = string
  default = "ami-096f5760b00bcd95c"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "security_group_name" {
  type    = string
  default = "github-runner"
}

variable "name_prefix" {
  type    = string
  default = "demo-vm"
}
