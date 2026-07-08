resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.project_name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_subnet" "Public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnetipPublic
  availability_zone = "ap-south-1a"

  tags = {
    Name = "${var.project_name}-public-1"
  }
}

resource "aws_subnet" "Private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnetipPrivate
  availability_zone = "ap-south-1a"

  tags = {
    Name = "${var.project_name}-private-1"
  }
}

resource "aws_subnet" "Public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnetipPublic1
  availability_zone = "ap-south-1b"

  tags = {
    Name = "${var.project_name}-public-2"
  }
}

resource "aws_subnet" "Private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnetipPrivate1
  availability_zone = "ap-south-1b"

  tags = {
    Name = "${var.project_name}-private-2"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-route-table"
  }
}

