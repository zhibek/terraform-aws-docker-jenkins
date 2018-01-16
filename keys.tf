resource "aws_key_pair" "default" {
    key_name = "${var.org}-${var.env}-${var.region}"
    public_key = "${file("./.private/aws-key.pem.pub")}"
}
