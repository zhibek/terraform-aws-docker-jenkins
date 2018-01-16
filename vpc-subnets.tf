resource "aws_subnet" "public-z1" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "${var.region}${var.az_1}"

    tags {
        name = "${var.org}-${var.env}-${var.region}-public-z1"
        org = "${var.org}"
        env = "${var.env}"
        director = "terraform"
    }
}
