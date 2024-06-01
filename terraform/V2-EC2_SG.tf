

provider "aws" {
  region = "us-west-2" # Choose your desired region
}

resource "aws_instance" "demo-server" {
  ami             = "ami-0f7197c592205b389"
  instance_type   = "t2.micro"
  key_name        = "mysshkey"
  security_groups = "demo-sg"
}

resource "aws_security_group" "demo-sg" {
  name        = "allow-ssh"
  description = "To Allow SSH on IPV4"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
