variable "REGION" {
  default = "ap-northeast-1"
}

variable "ZONE1" {
  default = "ap-northeast-1a"
}
variable "ZONE3" {
  default = "ap-northeast-1c"
}
variable "ZONE4" {
  default = "ap-northeast-1d"
}

variable "AMIS" {
  type = map(any)
  default = {
    ap-northeast-1 = "ami-0e0820ad173f20fbb"
    ap-northeast-2 = "ami-0fd48c6031f8700df"
  }
}

variable "USER" {
  default = "ec2-user"
}

variable "MYIP" {
  default = "205.198.121.17/32"
}
