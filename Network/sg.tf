#SG/Network ---------------------------------------------
resource "aws_security_group" "DS_Access" {
  name        = "DSSG"
  description = "DataSync Security Group"
  vpc_id      = aws_vpc.VPC_For.id

  # Inbound Rules
  ingress {
    description = "Port 80 (HTTP) for agent activation"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Use your IP, or use a .tfvars to hide the IP value [var.access_ip]
  }

  # Out Rules
  egress {
    description = "Port 443 for communication with the AWS DataSync service"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Use your IP, or use a .tfvars to hide the IP value [var.access_ip]
  }

  egress {
    description = "Port 2049 for NFS v4.1 communications to the server subnet"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.10.2.0/24"] # Use your IP, or use a .tfvars to hide the IP value [var.access_ip]
  }

  tags = {
    Name = "DataSync-Access"
  }
}

#SG_02 ===========================================
resource "aws_security_group" "NFSSG" {
  name        = "NFSSG-SeverAccess"
  description = "SG of NFS SERVER"
  vpc_id      = aws_vpc.VPC_For.id

  # Inbound Rules --------------
  ingress {
    description = "NFS from specific subnet"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.10.1.0/24"] # Subnet CIDR
  }

  ingress {
    description = "NFS from specific subnet"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.10.2.0/24"] # Subnet CIDR
  }

  ingress {
    description = "SSH for management"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Consider restricting this to a specific IP range for security
  }

  # Out Rules -----------
  egress {
    description = "NFS to specific subnet"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.10.1.0/24"] # Subnet CIDR
  }

  egress {
    description = "NFS to specific subnet"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.10.2.0/24"] # Subnet CIDR
  }

  tags = {
    Name = "ServerAccess-NFS"
  }
}

#SG_03 ------------------------------------------
resource "aws_security_group" "Client_Access" {
  name        = "ClientAccess"
  description = "ClientAccess SG"
  vpc_id      = aws_vpc.VPC_For.id
  # Regla de entrada
  ingress {
    description = "SSH for management"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Use your IP, or use a .tfvars to hide the IP value [var.access_ip]
  }

  # Regla de salida
  egress {
    description = "NFS to specific subnet"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.10.2.0/24"] # Subnet CIDR
  }

  tags = {
    Name = "ClientAccess-SG"
  }
}


#SG_04 ------------------------------------------
resource "aws_security_group" "FGTW" {
  name        = "FGTW"
  description = "File Gateway access SG"
  vpc_id      = aws_vpc.VPC_For.id

  # Reglas de entrada
  ingress {
    description = "NFS"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.10.1.0/24"] # Subnet CIDR
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Use your IP, or use a .tfvars to hide the IP value [var.access_ip]
  }

  # Reglas de salida
  egress {
    description = "NFS"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.10.1.0/24"] # Subnet CIDR
  }

  egress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Use your IP, or use a .tfvars to hide the IP value [var.access_ip]
  }

  tags = {
    Name = "FileGatewayAccess-SG"
  }
}
