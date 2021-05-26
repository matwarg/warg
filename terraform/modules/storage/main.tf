# S3 bucket
resource "aws_s3_bucket" "terraform_warg" {
  bucket = "terraform-s3-warg"

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = var.lifecycle
  }

  # Enable versioning so we can see the full revision history of our
  versioning {
    enabled = var.versioning
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}