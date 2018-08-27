
# Create a VPC to launch our instances into
resource "aws_vpc" "terraform" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name = "${var.project_name}"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "terraform" {
  vpc_id = "${aws_vpc.terraform.id}"

  tags {
    Name = "${var.project_name}"
  }
}

resource "aws_route_table" "internet" {
  vpc_id = "${aws_vpc.terraform.id}"

  tags {
    Name = "${var.project_name}-internet"
  }
}

# Grant the VPC internet access
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_route_table.internet.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.terraform.id}"
}

# Create an association between the VPC and route table
resource "aws_main_route_table_association" "terraform" {
  vpc_id         = "${aws_vpc.terraform.id}"
  route_table_id = "${aws_route_table.internet.id}"
}

# Create a subnet to launch web servers into
resource "aws_subnet" "terraform_web_servers" {
  vpc_id                  = "${aws_vpc.terraform.id}"
  cidr_block              = "${var.vpc_cidr_web_servers}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.project_name}"
  }
}