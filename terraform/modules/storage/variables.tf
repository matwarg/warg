variable "lifecycle" {
  description = "Prevent accidental deletion of this S3 bucket"
  default     = "false"
  type        = string
}

variable "versioning" {
  description = "Not recomended for tests env"
  default     = "false"
  type        = string
}