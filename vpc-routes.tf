resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"

    tags {
        name = "${var.org}-${var.env}-${var.region}"
        org = "${var.org}"
        env = "${var.env}"
        director = "terraform"
    }
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        name = "${var.org}-${var.env}-${var.region}-public"
        org = "${var.org}"
        env = "${var.env}"
        director = "terraform"
    }
}

resource "aws_route_table_association" "public-z1" {
    subnet_id = "${aws_subnet.public-z1.id}"
    route_table_id = "${aws_route_table.public.id}"
}
