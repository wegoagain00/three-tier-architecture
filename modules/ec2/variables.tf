#when using this module, you need to pass the following variables cant be empty
variable "ami" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "security_group_ids" {
  type = list(string)
}
variable "tags" {
  description = "Tags to apply to the EC2 instance"
  type        = map(string)
  default     = {}
}
variable "key_name" {
  description = "Name of the AWS key pair"
  type        = string
}
