resource "aws_internet_gateway" "aws_igw" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "${local.env}-igw"
    }
}