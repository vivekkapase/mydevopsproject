terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"  # Choose your desired region
  access_key = "var.AWS_CLI_KEY_ID"
  secret_key = "var.AWS_CLI_KEY_SECRET"
  profile = "VKDevOps"  # Specify your AWS profile
}

resource "aws_instance" "test_server1" {
  ami           = "ami-0f7197c592205b389"  # Replace with your RHEL AMI ID
  instance_type = "t2.micro"
  tags = {
    Name = "MyRedHatInstance"  # Customize the instance name
  }
}

resource "aws_vpc" "vpc1" {
  cidr_block = "172.31.0.0/16"

  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "172.31.0.0/24"
  availability_zone = "us-west-2"

}

