provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "ssh_bastion" {

  tags {
    Name = "${var.project_name}-bastion"
  }

  instance_type = "${var.instance_type}"

  # Use red had enterprise linux
  ami = "${var.rhel_ami}"

  # The name of our SSH keypair.
  key_name = "${var.bastion_key_name}"

  # Allow outbound connections, inbound ssh connections and private ssh connections
  vpc_security_group_ids = ["${aws_security_group.default_outbound.id}","${aws_security_group.public_access.id}","${aws_security_group.private_access.id}"]

  # Add the bastion to the web-servers subnet for now
  # in production this should be in a different subnet
  subnet_id = "${aws_subnet.terraform_web_servers.id}"

}

resource "aws_instance" "web_server" {

  tags {
    Name = "${var.project_name}-web_server"
  }

  instance_type = "${var.instance_type}"

  # Use red had enterprise linux
  ami = "${var.rhel_ami}"

  # The name of our SSH keypair we created above.
  key_name = "${var.bastion_key_name}"

  # Our Security group to allow SSH access
  vpc_security_group_ids = ["${aws_security_group.default_outbound.id}","${aws_security_group.private_access.id}"]
  subnet_id = "${aws_subnet.terraform_web_servers.id}"

}