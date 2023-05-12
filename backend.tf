terraform {
  backend "s3" {
    bucket = "chenyunshu-test-bucket2"
    key    = "terraform/backend"
    region = "ap-northeast-1"
  }
}
