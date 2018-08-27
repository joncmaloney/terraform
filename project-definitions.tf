variable "project_name" {
  default = "terraform"
}

variable "aws_region" {
  default = "ap-southeast-2"
}

variable "rhel_ami" {
  default = "ami-67589505"
}

variable "user_name" {
  default = "ec2-user"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_cidr_web_servers" {
  default = "10.0.1.0/24"
}

//
// Outputs
//
output "bastion_host" {
  value = "${aws_instance.ssh_bastion.public_ip}"
}

output "web-server" {
  value = "${aws_instance.web_server.public_ip}"
}