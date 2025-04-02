resource "aws_subnet" "public_subnet_zone1" {
    vpc_id = aws_vpc.main.id
    availability_zone = local.available_zone1
    map_public_ip_on_launch = true
    cidr_block = "10.0.64.0/19"
    tags ={
        "Name"                                                    = "${local.env}-public-${local.available_zone1}" 
        "kubernetes.io/role/elb"                                  = "1"
        "kubernetes.io/cluster/${local.env}${local.cluster_name}" = "owned"
    }
}

resource "aws_subnet" "public_subnet_zone2" {
    vpc_id = aws_vpc.main.id
    availability_zone = local.available_zone2
    map_public_ip_on_launch = true
    cidr_block = "10.0.96.0/19"
    tags ={
        "Name"                                                    = "${local.env}-public-${local.available_zone2}" 
        "kubernetes.io/role/elb"                                  = "1"
        "kubernetes.io/cluster/${local.env}${local.cluster_name}" = "owned"
    }
}

resource "aws_subnet" "private_subnet_zone1" {
    vpc_id = aws_vpc.main.id
    availability_zone = local.available_zone1
    cidr_block = "10.0.0.0/19"
    tags = {
        "Name"                                                     = "${local.env}-private-${local.available_zone1}"
        "kubernetes.io/role/internal-elb"                          = "1"
        "kubernetes.io/cluster/${local.env}-${local.cluster_name}" = "owned"
    }
}

resource "aws_subnet" "private_subnet_zone2" {
    vpc_id = aws_vpc.main.id
    availability_zone = local.available_zone2
    cidr_block = "10.0.32.0/19"
    tags = {
        "Name"                                                     ="${local.env}-private-${local.available_zone2}"
        "kubernetes.io/role/internal-elb"                          = "1"
        "kubernetes.io/cluster/${local.env}-${local.cluster_name}" = "owned" 
    }
}
