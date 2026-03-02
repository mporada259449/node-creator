resource "aws_vpc" "runners" {
  cidr_block = var.cidr_main
  tags = {
    Name = "runners-vpc"
  }
}

resource "aws_internet_gateway" "runners_igw" {
  vpc_id = aws_vpc.runners.id
  tags = {
    Name = "runners-igw"
  }
}

resource "aws_subnet" "runners_private" {
  vpc_id            = aws_vpc.runners.id
  cidr_block        = var.cidr_private
  availability_zone = "eu-central-1a"
  tags = {
    Name = "runners-private-subnet"
  }
}

resource "aws_subnet" "runners_public" {
  vpc_id            = aws_vpc.runners.id
  cidr_block        = var.cidr_public
  availability_zone = "eu-central-1a"
  tags = {
    Name = "runners-public-subnet"
  }
}

resource "aws_eip" "runners_nat" {
  depends_on = [ aws_internet_gateway.runners_igw ]
}

resource "aws_nat_gateway" "runners_nat" {
  allocation_id = aws_eip.runners_nat.id
  subnet_id     = aws_subnet.runners_public.id
  tags = {
    Name = "runners-nat-gateway"
  }
}

resource "aws_route_table" "runners_private_rt" {
  vpc_id = aws_vpc.runners.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.runners_nat.id
  }
}

resource "aws_route_table" "runners_public_rt" {
  vpc_id = aws_vpc.runners.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.runners_igw.id  
  }
}

resource "aws_route_table_association" "runners_private_assoc" {
  subnet_id      = aws_subnet.runners_private.id
  route_table_id = aws_route_table.runners_private_rt.id
}

resource "aws_route_table_association" "runners_public_assoc" {
  subnet_id      = aws_subnet.runners_public.id
  route_table_id = aws_route_table.runners_public_rt.id
}