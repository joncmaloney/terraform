resource "null_resource" "connect_bastion" {
	# The connection block tells our provisioner how to
	# communicate with the resource (instance)
	connection {
		type          = "ssh"
		user          = "${var.user_name}"
		# Set the hostname of the bastion so we can 
		#	connect to other hosts via this bastion
		host          = "${aws_instance.ssh_bastion.public_ip}"
		private_key   = "${file("${var.bastion_key_path}")}"
	}

	# We run a remote provisioner on the instance after creating it.
	provisioner "remote-exec" {
		inline = [
		  "sudo yum -y update",
		  "sudo yum install -y wget nano"
		]
	}
}

resource "null_resource" "connect_web_server" {
# The connection block tells our provisioner how to
	# communicate with the resource (instance)
	connection {
		type          = "ssh"
		# The default username for our AMI
		user          = "${var.user_name}"
		# Connect to this host via the SSH Bastion
		bastion_host  = "${aws_instance.ssh_bastion.public_ip}"
		host          = "${aws_instance.web_server.private_ip}"
		private_key   = "${file("${var.bastion_key_path}")}"
	}

	# We run a remote provisioner on the instance after creating it.
	provisioner "remote-exec" {
		inline = [
			"sudo yum -y update",
			"sudo yum install -y wget nano git",
			"sudo yum install -y yum-utils device-mapper-persistent-data lvm2",
			"sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
			"sudo yum install -y http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.42-1.gitad8f0f7.el7.noarch.rpm",
			"sudo yum install -y docker-ce",
			"sudo systemctl start docker"
		]
	}
}