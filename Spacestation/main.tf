# Variables

variable "aws_region" {
  default = "us-east-1"
}

# AWS VPC

resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform-vpc"
  }
}

# AWS Subnets

resource "aws_subnet" "SpaceStation1" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.terraform-vpc.id
  availability_zone = "us-east-1a"
  tags = {
    Purpose = "exercise"
    Name = "SpaceStation1"
  }
}

resource "aws_subnet" "SpaceStation2" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.terraform-vpc.id
  availability_zone = "us-east-1b"
  tags = {
    Purpose = "exercise"
    Name = "SpaceStation2"
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

# Internet Gateway

resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "terraform-igw"
  }
}

# Route Table

resource "aws_route_table" "terraform-route-table" {
  vpc_id = aws_vpc.terraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-igw.id
  }
  tags = {
    Name = "terraform-route-table"
  }
}

# Route Table Associations

resource "aws_route_table_association" "SpaceStation1-route-table-association" {
  subnet_id = aws_subnet.SpaceStation1.id
  route_table_id = aws_route_table.terraform-route-table.id
}

resource "aws_route_table_association" "SpaceStation2-route-table-association" {
  subnet_id = aws_subnet.SpaceStation2.id
  route_table_id = aws_route_table.terraform-route-table.id
}

resource "aws_route_table_association" "SpaceStation3-route-table-association" {
  subnet_id = aws_subnet.SpaceStation3.id
  route_table_id = aws_route_table.terraform-route-table.id
}

# Security Group

resource "aws_security_group" "terraform-sg" {
  vpc_id = aws_vpc.terraform-vpc.id
  description = "Allow inbound SSH and all outbound traffic"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terraform-sg"
  }
}

# EC2 Instances for each Subnet

resource "aws_instance" "SpaceStation1-instance" {
  ami = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (change if necessary)
  instance_type = "t2.micro"
  subnet_id = aws_subnet.SpaceStation1.id
  security_groups = [aws_security_group.terraform-sg.name]
  tags = {
    Name = "SpaceStation1-instance"
  }
}

resource "aws_instance" "SpaceStation2-instance" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.SpaceStation2.id
  security_groups = [aws_security_group.terraform-sg.name]
  tags = {
    Name = "SpaceStation2-instance"
  }
}

resource "aws_instance" "SpaceStation3-instance" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.SpaceStation3.id
  security_groups = [aws_security_group.terraform-sg.name]
  tags = {
    Name = "SpaceStation3-instance"
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

output "InternetGateway-id" {
  value = aws_internet_gateway.terraform-igw.id
}

output "SecurityGroup-id" {
  value = aws_security_group.terraform-sg.id
}

output "SpaceStation1-instance-id" {
  value = aws_instance.SpaceStation1-instance.id
}

output "SpaceStation2-instance-id" {
  value = aws_instance.SpaceStation2-instance.id
}

output "SpaceStation3-instance-id" {
  value = aws_instance.SpaceStation3-instance.id
}
