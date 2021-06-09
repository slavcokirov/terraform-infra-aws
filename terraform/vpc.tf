resource "aws_vpc" "prod" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "exampleapp-prod"
  }
}

resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name = "exampleapp-prod"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod.id
  }

  tags = {
    Name = format("%s-${var.public_subnet_suffix}", "${var.infra_name}-${var.env}")
  }
}

resource "aws_route_table_association" "a" {
  count = length(var.public_subnets)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.prod.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = format("%s-${var.public_subnet_suffix}-%s", "${var.infra_name}-${var.env}", element(var.azs, count.index))
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.prod.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = format("%s-${var.private_subnet_suffix}-%s", "${var.infra_name}-${var.env}", element(var.azs, count.index))
  }
}

resource "aws_subnet" "dbsns" {
  count = length(var.db_subnets)

  vpc_id            = aws_vpc.prod.id
  cidr_block        = var.db_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = format("%s-${var.db_subnet_suffix}-%s", "${var.infra_name}-${var.env}", element(var.azs, count.index))
  }
}

resource "aws_eip" "natip" {
  count = length(var.public_subnets)

  vpc = true

  tags = {
      Name = format("%s-%s-%s", "${var.infra_name}-${var.env}", element(var.azs, count.index), "natGW")
  }
}

resource "aws_nat_gateway" "natgw" {
  count = length(var.public_subnets)

  allocation_id = element(aws_eip.natip.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = {
    Name = format("%s-%s", "${var.infra_name}-${var.env}", element(var.azs, count.index)) 
  }
}
