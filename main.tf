terraform {

  backend "s3" {
    bucket = "week19-bucket"
    key    = "my_states/terraform.tfstate"
    region = "us-east-1"
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}


resource "aws_vpc" "my_vpc" { 
  cidr_block = var.vpc_cidr
  tags = {
    Name = "my-vpc" 
  }
}

resource "aws_internet_gateway" "my_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_gateway"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr_block[0]
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr_block[1]
  availability_zone = "us-east-1a"
  tags = {
    Name = "private_subnet"
  }
}

#creating  route table for public subnet

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gateway.id
  }
}

#associating public route table with public subnet

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public_route.id
}

#NAT need elastic ip so create elastic ip

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "my_nat_gateway" {
 
  subnet_id = aws_subnet.public.id
  allocation_id = aws_eip.nat_eip.id
  tags = {
    Name = "my_nat_gateway"
  }
}

#creating route table for private

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.my_vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_nat_gateway.id
  }
  tags = {
    Name = "Privat_table"
  }
}

#Associating private route table with private subnet

resource "aws_route_table_association" "private_association" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private_route.id
}

# Creating security group

resource "aws_security_group" "all_traffic" {
  name = "all_traffic"
  description = "Allowing all traffic"
  vpc_id = aws_vpc.my_vpc.id
  ingress   {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0 
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Creating instances

resource "aws_instance" "public" {
  ami = var.ami_id
  instance_type = "t2.micro"
  key_name = "week19"
  subnet_id = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.all_traffic.id]

  tags = {
    Name = "public"
  }
  
}

resource "aws_instance" "private" {
  ami = var.ami_id
  instance_type = "t2.micro"
  key_name = "week19"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.all_traffic.id]

  tags = {
    Name = "private"
  }
}