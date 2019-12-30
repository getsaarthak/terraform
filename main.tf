provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "example" {
  key_name   = "key"
#  public_key = "SHA256:AA7PjKaZzKeRAv8Fi1nXdW4ECZgd+BAoIbVc6N0o/sk vagrant@m1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC682U2nSQJKBUTvwwQpewSOkfkFo86gxyFjHRTc9AzZRY3hHZZMKVzTAV3AfboALRdV//BP9E9ngk8yjCtgnXCbLNQrwOTaJj0/b2pYMVq2QunIXqs+2ugJZl5pIlx4hfy5jSkxu/xXaCHVFlKAUczbogyqVZ8EhfuNO+w0INKLYTUE+beDMylwbIS+ZStJQCwSBfv+OZ8LPa3wbluLBokoGG+VoWopwpgd/G6LK5nRZU+5QXH3cDHK4+EiHZ2mhNukByNHiHZ/Os88MSLHyul2H2veKLDWWdaStHtL71TurfXoQK2EObfTaZ7Hyb1Og+EoJTWf76aj010bVvZhJTV vagrant@m1"
}


resource "aws_security_group" "examplesg" {
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-03d68f1b6fcf93e47"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.examplesg.id}"]
  key_name               = "${aws_key_pair.example.id}"
  tags = {
    Name = "my-first-ec2-instance"
  }
}
