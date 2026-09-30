resource "random_id" "random" {

  byte_length = 8
}
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "demo-abc-123456-abc-123456"

}
