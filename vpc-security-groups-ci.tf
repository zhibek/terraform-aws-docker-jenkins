resource "aws_security_group" "unrestricted-outgoing" {
    name = "${var.org}-${var.env}-unrestricted-outgoing"
    description = "unrestricted-outgoing security group"
    vpc_id = "${aws_vpc.default.id}"

    tags {
        name = "${var.org}-${var.env}-unrestricted-outgoing"
        org = "${var.org}"
        env = "${var.env}"
        director = "terraform"
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
    name = "${var.org}-${var.env}-private-ssh"
    description = "private-ssh security group"
    vpc_id = "${aws_vpc.default.id}"

    tags {
        name = "${var.org}-${var.env}-private-ssh"
        org = "${var.org}"
        env = "${var.env}"
        director = "terraform"
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
    name = "${var.org}-${var.env}-ci-http"
    description = "ci-http security group"
    vpc_id = "${aws_vpc.default.id}"

    tags {
        name = "${var.org}-${var.env}-ci-http"
        org = "${var.org}"
        env = "${var.env}"
        director = "terraform"
        job = "ci"
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
