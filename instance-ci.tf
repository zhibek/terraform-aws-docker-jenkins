resource "aws_instance" "ci" {
    ami = "${var.services_ami}"
    instance_type = "t2.micro"
    availability_zone = "${aws_subnet.public-z1.availability_zone}"
    subnet_id = "${aws_subnet.public-z1.id}"
    vpc_security_group_ids = ["${aws_security_group.unrestricted-outgoing.id}","${aws_security_group.private-ssh.id}","${aws_security_group.ci-http.id}"]
    key_name = "${aws_key_pair.default.key_name}"
    associate_public_ip_address = true

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get update",
            "sudo apt-get -y install curl",
            "curl -sSL https://get.docker.com/ | sudo sh",
            <<EOT
sudo docker run -d \
    -u root \
    -p 8080:8080 \
    -p 50000:50000 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v jenkins_home:/var/jenkins_home \
    jenkinsci/blueocean
EOT
        ]
        connection {
            user = "ubuntu"
            private_key = "${file("./.private/aws-key.pem")}"
        }
    }

    tags {
        Name = "${var.client}-${var.tag}-ci"
        deployment = "${var.client}-${var.tag}-ci"
        director = "terraform"
        job = "ci"
        Client = "${var.client}"
    }
}
