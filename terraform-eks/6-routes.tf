resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "${local.env}-private"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${local.env}-public"
  }
}


resource "aws_route_table_association" "private_zone1" {
  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.private_zone1.id
}

resource "aws_route_table_association" "private_zone2" {
  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.private_zone2.id
}


resource "aws_route_table_association" "public_zone1" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public_zone1.id
}

resource "aws_route_table_association" "public_zone2" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public_zone2.id
}