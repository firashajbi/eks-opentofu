resource "aws_route_table" "private_table" {
    vpc_id = aws_vpc.main.id
    
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
      Name = "${local.env}-private"
    }
  
}

resource "aws_route_table_association" "private_association_zone1" {
    subnet_id = aws_subnet.private_subnet_zone1.id
    route_table_id = aws_route_table.private_table.id
  
}

resource "aws_route_table_association" "private_association_zone2" {
    subnet_id = aws_subnet.private_subnet_zone2.id
    route_table_id = aws_route_table.private_table.id
  
}

resource "aws_route_table" "public_table" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.aws_igw.id
    }
    tags = {
        Name = "${local.env}-public"
    }
}

resource "aws_route_table_association" "public_association_zone1" {
    subnet_id = aws_subnet.public_subnet_zone1.id
    route_table_id = aws_route_table.public_table.id
  
}

resource "aws_route_table_association" "public_association_zone2" {
    subnet_id = aws_subnet.public_subnet_zone2.id
    route_table_id = aws_route_table.public_table.id
  
}