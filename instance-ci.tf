resource "aws_instance" "ci" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"
    availability_zone = "${aws_subnet.public-z1.availability_zone}"
    subnet_id = "${aws_subnet.public-z1.id}"
    vpc_security_group_ids = ["${aws_security_group.unrestricted-outgoing.id}","${aws_security_group.private-ssh.id}","${aws_security_group.ci-http.id}"]
    key_name = "${aws_key_pair.default.key_name}"
    associate_public_ip_address = true

    tags {
        Name = "${var.client}-${var.tag}-ci"
        Client = "${var.client}"
        deployment = "${var.client}-${var.tag}-ci"
        director = "terraform"
        job = "ci"
    }
}

resource "aws_ebs_volume" "ci" {
    availability_zone = "${aws_subnet.public-z1.availability_zone}"
    size              = 8

    tags {
        Name = "${var.client}-${var.tag}-ci-volume"
        Client = "${var.client}"
    }
}

resource "aws_volume_attachment" "ci" {
    device_name  = "/dev/sdh"
    volume_id    = "${aws_ebs_volume.ci.id}"
    instance_id  = "${aws_instance.ci.id}"

    provisioner "remote-exec" {
        script = "remote_scripts/setup_ci.sh"
        connection {
            host = "${aws_instance.ci.public_ip}"
            user = "ubuntu"
            private_key = "${file("./.private/aws-key.pem")}"
        }
    }
}
