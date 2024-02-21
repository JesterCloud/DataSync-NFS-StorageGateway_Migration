# Network/Main --------

resource "aws_vpc" "VPC_For" {
  cidr_block           = var.vcp_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  # Recordar que el VPC_ID se llama en Outputs

  tags = {
    Name = "VPC_Probar"
  }
}

# Client SUBNET ============================================================
resource "aws_subnet" "Client_Subnet" {
  vpc_id                  = aws_vpc.VPC_For.id
  cidr_block              = var.public_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Client-Subnet"
  }
}

# My AWS Server SUBNET ============================================================
resource "aws_subnet" "Server_Subnet" {
  vpc_id                  = aws_vpc.VPC_For.id
  cidr_block              = var.server_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "Server-Subnet"
  }
}

# IGW ============================================================
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC_For.id

  tags = {
    Name = "Internet-Gateway-Public"
  }

}


# RT ============================================================
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.VPC_For.id

  tags = {
    Name = "Route-Table-Public"
  }
}

# RT Association -----------
resource "aws_route_table_association" "RTAss" {
  subnet_id      = aws_subnet.Client_Subnet.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "RTAss02" {
  subnet_id      = aws_subnet.Server_Subnet.id
  route_table_id = aws_route_table.RT.id
}

# RT al IGW -----------
resource "aws_route" "Public_Route" {
  route_table_id         = aws_route_table.RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id
}