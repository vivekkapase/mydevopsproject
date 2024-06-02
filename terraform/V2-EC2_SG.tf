

provider "aws" {
  region = "us-west-2" # Choose your desired region
}

resource "aws_instance" "demo-server" {
  ami           = "ami-0f7197c592205b389"
  instance_type = "t2.micro"
  key_name      = "mysshkey"
  //vpc_security_group_ids = [aws_security_group.demo-sg.id]
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  subnet_id              = aws_subnet.project-subnet-01.id

}

resource "aws_security_group" "demo-sg" {
  name        = "Allow-SSH-ACCESS"
  description = "To Allow SSH on IPV4"
  vpc_id      = aws_vpc.project-vpc.id
  ingress {
    description = "Allow SSH"
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

resource "aws_vpc" "project-vpc" {
  cidr_block = "10.100.0.0/16"
  tags = {
    name = "myvpc"
  }
}

resource "aws_subnet" "project-subnet-01" {
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = "10.100.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"
  tags = {
    Name = "project-subnet-01"
  }
}
resource "aws_subnet" "project-subnet-02" {
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = "10.100.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2b"
  tags = {
    Name = "project-subnet-02"
  }
}

resource "aws_internet_gateway" "project-igw" {
  vpc_id = aws_vpc.project-vpc.id

  tags = {
    Name = "project-igw"
  }
}

resource "aws_route_table" "project-rt" {
  vpc_id = aws_vpc.project-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-igw.id
  }
  tags = {
    Name = "project-rt"
  }

}
resource "aws_route_table_association" "project-rta-subnet01" {
  subnet_id      = aws_subnet.project-subnet-01.id
  route_table_id = aws_route_table.project-rt.id
}
resource "aws_route_table_association" "project-rta-subnet02" {
  subnet_id      = aws_subnet.project-subnet-02.id
  route_table_id = aws_route_table.project-rt.id
}
