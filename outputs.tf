output "aws_vpc-default-id" {
    value = "${aws_vpc.default.id}"
}

output "aws_vpc-default-region" {
    value = "${var.region}"
}

output "aws_platform-name" {
    value = "${var.org}-${var.env}-${var.region}"
}

####################################################################################################
## Subnets
####################################################################################################

## Public

output "aws_subnet-public-z1-cidr_block" {
    value = "${aws_subnet.public-z1.cidr_block}"
}

output "aws_subnet-public-z1-availability" {
    value = "${aws_subnet.public-z1.availability_zone}"
}

output "aws_subnet-public-z1-id" {
    value = "${aws_subnet.public-z1.id}"
}

####################################################################################################
## Security Groups
####################################################################################################

output "aws_security_group-unrestricted-outgoing-name" {
    value = "${aws_security_group.unrestricted-outgoing.name}"
}

output "aws_security_group-unrestricted-outgoing-id" {
    value = "${aws_security_group.unrestricted-outgoing.id}"
}

output "aws_security_group-private-ssh-name" {
    value = "${aws_security_group.private-ssh.name}"
}

output "aws_security_group-private-ssh-id" {
    value = "${aws_security_group.private-ssh.id}"
}

output "aws_security_group-ci-http-name" {
    value = "${aws_security_group.ci-http.name}"
}

output "aws_security_group-ci-http-id" {
    value = "${aws_security_group.ci-http.id}"
}

####################################################################################################
## CI
####################################################################################################

output "aws_instance-ci-public_dns" {
    value = "${aws_instance.ci.public_dns}"
}
