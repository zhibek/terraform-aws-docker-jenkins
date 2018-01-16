resource "aws_vpc" "default" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags {
        name = "${var.org}-${var.env}-${var.region}"
        org = "${var.org}"
        env = "${var.env}"
        director = "terraform"
    }
}
