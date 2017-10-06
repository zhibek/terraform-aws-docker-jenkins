resource "aws_key_pair" "default" {
    key_name = "${var.client}-${var.tag}-${var.region}"
    public_key = "${file("./.private/aws-key.pem.pub")}"
}
