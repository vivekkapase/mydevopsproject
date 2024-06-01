

provider "aws" {
  region = "us-west-2" # Choose your desired region
}

resource "aws_instance" "demo-server" {
  ami           = "ami-0f7197c592205b389"
  instance_type = "t2.micro"
  key_name      = "mysshkey"
}

