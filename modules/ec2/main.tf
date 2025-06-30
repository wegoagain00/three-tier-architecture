# created reusable module for creating an EC2 instance
# This module creates an EC2 instance with the specified parameters.
# variables.tf defines the input variables for the module
resource "aws_instance" "ec2_instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = var.security_group_ids
  key_name        = var.key_name

  tags = var.tags
}
