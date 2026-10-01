terraform {
  backend "s3" {
    bucket       = "demo-abc-123456-abc-123456"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
