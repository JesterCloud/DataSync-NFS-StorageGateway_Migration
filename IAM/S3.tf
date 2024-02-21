resource "aws_iam_role" "s3bucketaccess" {
  name = "S3BucketAccess"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com" # o cualquier otro servicio de AWS que asumirá el rol
        }
      },
    ]
  })
}

resource "aws_iam_policy" "s3bucketaccess_policy" {
  name        = "S3BucketAccessPolicy"
  description = "Acceso completo a todos los buckets de S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "s3:*",
        Resource = "*",
        Effect   = "Allow"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3bucketaccess_attach" {
  role       = aws_iam_role.s3bucketaccess.name
  policy_arn = aws_iam_policy.s3bucketaccess_policy.arn
}