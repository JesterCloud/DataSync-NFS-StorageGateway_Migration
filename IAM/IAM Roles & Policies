resource "aws_iam_role" "ec2full" {
  name = "EC2Full"

  # La política de confianza que permite que el servicio EC2 asuma este rol.
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
      },
    ]
  })
}

resource "aws_iam_policy" "ec2full_policy" {
  name        = "EC2FullPolicy"
  description = "Política que permite acciones específicas en S3 y EC2"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::us-west-2-aws-training"
        ],
        Effect = "Allow"
      },
      {
        Action = [
          "s3:GetObject"
        ],
        Resource = [
          "arn:aws:s3:::us-west-2-aws-training/courses/spl-247/v1.0.9.prod-f1b6e83d/scripts/data/*"
        ],
        Effect = "Allow"
      },
      {
        Action = [
          "s3:HeadBucket"
        ],
        Resource = [
          "*"
        ],
        Effect = "Allow"
      },
      {
        Action = [
          "ec2:RevokeSecurityGroupEgress"
        ],
        Resource = [
          "*"
        ],
        Effect = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2full_attach" {
  role       = aws_iam_role.ec2full.name
  policy_arn = aws_iam_policy.ec2full_policy.arn
}
