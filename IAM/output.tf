# Outputs/IAM -----------------------

output "IAM_Output" {
  value = aws_iam_role.ec2full.name
}