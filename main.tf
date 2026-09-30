resource "random_id" "random" {

  byte_length = 8
}
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "demo-abc-123456-abc-123456"

}
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "private_subnet" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.demo-vpc.id
  availability_zone = var.availability_zone
}
resource "aws_subnet" "public_subnet" {
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.demo-vpc.id
  availability_zone = var.availability_zone
}
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id
}
resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }
}

resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.demo-rt.id
  subnet_id      = aws_subnet.public_subnet.id
}

resource "aws_instance" "demo-ec2-instance" {
  ami               = "ami-0b245cc5f82576748"
  instance_type     = "t3.micro"
  subnet_id         = aws_subnet.public_subnet.id
  availability_zone = var.availability_zone
  security_groups   = [aws_security_group.demo-firewall.id]
}

resource "aws_security_group" "demo-firewall" {
  vpc_id = aws_vpc.demo-vpc.id
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["192.168.15.170/32"]
  }
}
