# Network/Output -------------------------
output "vpc_id" {
  value = aws_vpc.VPC_For.id
}

output "NFSSGServerSG_Output" {
  value = aws_security_group.NFSSG.id
}

output "NFSSubnet_Output" {
  value = aws_subnet.Server_Subnet.id
}

# Client On-Prem Outputs  ------------------------------------
output "Client_ServerSG_Output" {
  value = aws_security_group.Client_Access.id
}

output "Client_ServerSubnet_Output" {
  value = aws_subnet.Client_Subnet.id
}
