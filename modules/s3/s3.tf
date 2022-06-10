
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  acl    = var.acl

  tags = {
    Name = "my_bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "public_storage" {
  depends_on          = [aws_s3_bucket.my_bucket]
  bucket              = var.bucket_name
  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_versioning" "version" {
  bucket = var.bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "dynamodb_table" {
  name         = "terraform-state-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "Terraform LockID"
  }
}