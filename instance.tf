resource "aws_key_pair" "web-key" {
  key_name   = "web-key"
  public_key = file("web-key.pub")
}

resource "aws_instance" "web01-instance" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.web01-pub-1.id
  key_name               = aws_key_pair.web-key.key_name
  vpc_security_group_ids = [aws_security_group.web01-sg.id]
  tags = {
    Name    = "web01-instance"
    Project = "Web"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("web-key")
    host        = self.public_ip
  }
}

resource "aws_ebs_volume" "vol_web01" {
  availability_zone = var.ZONE1
  size              = 3
  tags = {
    Name = "extra-vol-web01"
  }
}

resource "aws_volume_attachment" "attach_vol_web01" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.vol_web01.id
  instance_id = aws_instance.web01-instance.id
}

output "PublicIP" {
  value = aws_instance.web01-instance.public_ip
}

output "PrivateIP" {
  value = aws_instance.web01-instance.private_ip
}
