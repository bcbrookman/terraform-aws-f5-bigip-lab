resource "aws_vpc" "f5lab_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"
    tags = {
    Name = "f5lab_vpc"
  }
}

resource "aws_subnet" "f5lab_external_net" {
  vpc_id = aws_vpc.f5lab_vpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "f5lab_external_net"
  }
}

resource "aws_subnet" "f5lab_internal_net" {
  vpc_id     = aws_vpc.f5lab_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "f5lab_internal_net"
  }
}

resource "aws_internet_gateway" "f5lab_igw" {
  vpc_id = aws_vpc.f5lab_vpc.id
  tags = {
    Name = "f5lab_igw"
  }
}

resource "aws_route_table" "f5lab_internal_rt" {
  vpc_id = aws_vpc.f5lab_vpc.id
  tags = {
    Name = "f5lab_internal_rt"
  }
}

resource "aws_route_table" "f5lab_external_rt" {
  vpc_id = aws_vpc.f5lab_vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.f5lab_igw.id
  }
  tags = {
    Name = "f5lab_external_rt"
  }
}

resource "aws_route_table_association" "f5lab_internal_rt_association" {
  subnet_id = aws_subnet.f5lab_internal_net.id
  route_table_id = aws_route_table.f5lab_internal_rt.id
}

resource "aws_route_table_association" "f5lab_external_rt_association" {
  subnet_id = aws_subnet.f5lab_external_net.id
  route_table_id = aws_route_table.f5lab_external_rt.id
}
