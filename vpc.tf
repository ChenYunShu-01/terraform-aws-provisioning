resource "aws_vpc" "web01" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "web01"
  }
}

resource "aws_subnet" "web01-pub-1" {
  vpc_id                  = aws_vpc.web01.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "web01-pub-1"
  }
}
resource "aws_subnet" "web01-pub-2" {
  vpc_id                  = aws_vpc.web01.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "web01-pub-2"
  }
}
resource "aws_subnet" "web01-pub-3" {
  vpc_id                  = aws_vpc.web01.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "web01-pub-3"
  }
}

resource "aws_subnet" "web01-priv-1" {
  vpc_id                  = aws_vpc.web01.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "web01-priv-1"
  }
}

resource "aws_subnet" "web01-priv-2" {
  vpc_id                  = aws_vpc.web01.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE4
  tags = {
    Name = "web01-priv-2"
  }
}
resource "aws_subnet" "web01-priv-3" {
  vpc_id                  = aws_vpc.web01.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE4
  tags = {
    Name = "web01-priv-2"
  }
}

resource "aws_internet_gateway" "web01-gw" {
  vpc_id = aws_vpc.web01.id

  tags = {
    Name = "web01-gw"
  }
}

resource "aws_route_table" "web01-pub-RT" {
  vpc_id = aws_vpc.web01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web01-gw.id
  }

  tags = {
    Name = "web01-RT"
  }
}

resource "aws_route_table_association" "web01-pub-1-a" {
  subnet_id      = aws_subnet.web01-pub-1.id
  route_table_id = aws_route_table.web01-pub-RT.id
}

resource "aws_route_table_association" "web01-pub-2-a" {
  subnet_id      = aws_subnet.web01-pub-2.id
  route_table_id = aws_route_table.web01-pub-RT.id
}

resource "aws_route_table_association" "web01-pub-3-a" {
  subnet_id      = aws_subnet.web01-pub-3.id
  route_table_id = aws_route_table.web01-pub-RT.id
}
