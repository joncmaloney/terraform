//
// Default Outbound connections
//
resource "aws_security_group" "default_outbound" {
  name        = "default_outbound"
  description = "Default Egress"
  vpc_id      = "${aws_vpc.terraform.id}"

  tags {
    Name = "${var.project_name}-default_outbound"
  }
}

resource "aws_security_group_rule" "default_outbound" {
  security_group_id = "${aws_security_group.default_outbound.id}"
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

//
// Administrative Access Public
//
resource "aws_security_group" "public_access" {
  name        = "public_access"
  description = "SSH Access Public"
  vpc_id      = "${aws_vpc.terraform.id}"

  tags {
    Name = "${var.project_name}-public_access"
  }
}

resource "aws_security_group_rule" "public_access_ssh" {
  security_group_id = "${aws_security_group.public_access.id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

//
// Administrative Access Private
//
resource "aws_security_group" "private_access" {
  name        = "private_access"
  description = "Private Access"
  vpc_id      = "${aws_vpc.terraform.id}"

  tags {
    Name = "${var.project_name}-private_access"
  }
}

resource "aws_security_group_rule" "private_access_ssh" {
  security_group_id = "${aws_security_group.private_access.id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["${var.vpc_cidr}"]
}