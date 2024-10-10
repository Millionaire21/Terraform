# Variables

resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"
}

# AWS Subnets

resource "aws_subnet" "NewSubnet1" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.terraform-vpc.id
  availability_zone = "us-east-1a"
  tags = {
    Purpose ="exercise"
    Name = "NewSubnet1"
  }
}

resource "aws_subnet" "NewSubnet2" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.terraform-vpc.id
  availability_zone = "us-east-1b"
  tags = {
    Purpose= "exercise"
    Name= "NewSubnet2"
  }
}

resource "aws_subnet" "NewSubnet3" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.terraform-vpc.id
  availability_zone = "us-east-1c"
  tags = {
    Purpose = "exercise"
    Name = "NewSubnet3"
  }
}

# Outputs

output "NewSubnet1-id" {
  value = aws_subnet.NewSubnet1.id
}
output "NewSubnet2-id" {
  value = aws_subnet.NewSubnet2.id
}
output "NewSubnet3-id" {
  value = aws_subnet.NewSubnet3.id
}