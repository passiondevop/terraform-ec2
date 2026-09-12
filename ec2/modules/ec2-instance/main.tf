data "aws_security_group" "existing" {
  filter {
    name   = "group-name"
    values = [var.security_group_name]
  }
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_instance" "vm" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [data.aws_security_group.existing.id]

  tags = {
    Name = "${var.name_prefix}-${count.index + 1}"
  }
}
