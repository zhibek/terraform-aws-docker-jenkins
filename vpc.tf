resource "aws_vpc" "default" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags {
        Name = "${var.client}-${var.tag}-${var.region}"
        Client = "${var.client}"
    }
}
