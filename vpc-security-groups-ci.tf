resource "aws_security_group" "unrestricted-outgoing" {
    name = "${var.client}-${var.tag}-unrestricted-outgoing"
    description = "unrestricted-outgoing security group"
    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "${var.client}-${var.tag}-unrestricted-outgoing"
        Client = "${var.client}"
    }
}

resource "aws_security_group_rule" "unrestricted-outgoing-allow-all-egress" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.unrestricted-outgoing.id}"
}

resource "aws_security_group" "private-ssh" {
    name = "${var.client}-${var.tag}-private-ssh"
    description = "private-ssh security group"
    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "${var.client}-${var.tag}-private-ssh"
        Client = "${var.client}"
    }
}

resource "aws_security_group_rule" "private-ssh-allow-private-tcp-22-ingress" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${split(", ", var.private_access_ips)}"]
    security_group_id = "${aws_security_group.private-ssh.id}"
}

resource "aws_security_group" "ci-http" {
    name = "${var.client}-${var.tag}-ci-http"
    description = "ci-http security group"
    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "${var.client}-${var.tag}-ci-http"
        Client = "${var.client}"
    }
}

resource "aws_security_group_rule" "ci-http-allow-private-tcp-8080-ingress" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["${split(", ", var.private_access_ips)}"]
    security_group_id = "${aws_security_group.ci-http.id}"
}