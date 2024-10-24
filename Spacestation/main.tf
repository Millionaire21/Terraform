# Variables

resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"
}

# AWS Subnets

resource "aws_subnet" "SpaceStation1" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.terraform-vpc.id
  availability_zone = "us-east-1a"
  tags = {
    Purpose ="exercise"
    Name = "SpaceStation1"
  }
}

resource "aws_subnet" "SpaceStation2" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.terraform-vpc.id
  availability_zone = "us-east-1b"
  tags = {
    Purpose= "exercise"
    Name= "SpaceStation2"
  }
}

resource "aws_subnet" "SpaceStation3" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.terraform-vpc.id
  availability_zone = "us-east-1c"
  tags = {
    Purpose = "exercise"
    Name = "SpaceStation3"
  }
}

# Outputs

output "SpaceStation1-id" {
  value = aws_subnet.SpaceStation1.id
}
output "SpaceStation2-id" {
  value = aws_subnet.SpaceStation2.id
}
output "SpaceStation3-id" {
  value = aws_subnet.SpaceStation3.id
}