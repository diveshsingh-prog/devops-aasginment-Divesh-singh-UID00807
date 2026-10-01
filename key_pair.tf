resource "tls_private_key" "crypto-key" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}
resource "aws_key_pair" "demo_key_pair" {
  public_key = tls_private_key.crypto-key.public_key_openssh

}
resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.crypto-key.private_key_pem
  filename        = "${path.module}/key.prem"
  file_permission = "0600"
}
