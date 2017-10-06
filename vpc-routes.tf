resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "${var.client}-${var.tag}-${var.region}"
        Client = "${var.client}"
    }
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "${var.client}-${var.tag}-${var.region}-public"
        Client = "${var.client}"
    }
}

resource "aws_route_table_association" "public-z1" {
    subnet_id = "${aws_subnet.public-z1.id}"
    route_table_id = "${aws_route_table.public.id}"
}
