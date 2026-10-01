
resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc_cidr_block[0]
  tags = {
    name = "demo-vpc"
  }
}
resource "aws_subnet" "demo_private_subnet" {
  cidr_block        = var.vpc_cidr_block[1]
  vpc_id            = aws_vpc.demo-vpc.id
  availability_zone = var.availability_zone
  tags = {
    name = "demo_private_subnet"
  }
}
resource "aws_subnet" "demo_public_subnet" {
  cidr_block        = var.vpc_cidr_block[2]
  vpc_id            = aws_vpc.demo-vpc.id
  availability_zone = var.availability_zone
  tags = {
    name = "demo_public_subnet"
  }
}
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    name = "demo-igw"
  }
}
resource "aws_route_table" "demo-public_rt" {
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block = var.all_ips
    gateway_id = aws_internet_gateway.demo-igw.id
  }
  tags = {
    name = "demo-public_rt"
  }
}
resource "aws_route_table" "demo-private_rt" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    name = "demo-private_rt"
  }
}
resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.demo-public_rt.id
  subnet_id      = aws_subnet.demo_public_subnet.id
}
resource "aws_route_table_association" "private-sub" {
  route_table_id = aws_route_table.demo-private_rt.id
  subnet_id      = aws_subnet.demo_private_subnet.id
}

