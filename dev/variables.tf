variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the instances"
  default = "ami-096f5760b00bcd95c"

}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
