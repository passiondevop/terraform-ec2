provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "ec2_vms" {
  source = "../modules/ec2-instance"

  instance_count      = 2
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  subnet_id           = data.aws_subnets.default.ids[0]
  vpc_id              = data.aws_vpc.default.id
  security_group_name = "github-runner"
  name_prefix         = "demo-vm"
}
