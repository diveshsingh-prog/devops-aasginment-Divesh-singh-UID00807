
resource "aws_instance" "demo-ec2-instance" {
  ami                         = data.aws_ami.ami_id.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.demo_public_subnet.id
  availability_zone           = var.availability_zone
  key_name                    = aws_key_pair.demo_key_pair.key_name
  security_groups             = [aws_security_group.demo-firewall.id]
}
resource "aws_security_group" "demo-firewall" {
  vpc_id = aws_vpc.demo-vpc.id
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["132.154.64.35/32"]
  }
}
