resource "aws_s3_bucket" "nfs_file_share" {
  bucket = "nfs-file-share-for-s3-try"
  acl    = "private" # Puedes cambiar esto a "public-read" si quieres que el bucket sea público

  tags = {
    Name        = "nfs-file-share-for-s3-try"
    Environment = "Production"
  }
}
