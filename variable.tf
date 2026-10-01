variable "region" {
  default = "us-east-1"
}
variable "availability_zone" {
  default = "us-east-1a"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "private_subnet" {
  default = "10.0.1.0/24"
}
variable "public_subnet" {
  default = "10.0.2.0/24"
}
variable "all_ips" {
  default = "0.0.0.0/0"
}

variable "instance_type" {
  default = "t3.micro"
}
variable "bucket_name" {
  default = "demo-abc-123456-abc-123456"
}
