resource "aws_eip" "nat" {
    domain = "vpc"
    tags = {
        Name = "${local.env}-nat"
    }
  
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public_subnet_zone1.id
    depends_on = [ aws_internet_gateway.aws_igw ]
    tags= {
        Name = "${local.env}-nat"
    }
  
}
