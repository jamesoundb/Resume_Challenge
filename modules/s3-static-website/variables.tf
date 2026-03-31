variable "bucket_name" {
  description = "Name of the S3 bucket for static website hosting"
  type        = string
}

variable "acl" {
  description = "ACL for the S3 bucket and objects"
  type        = string
  default     = "public-read"
}

variable "index_document" {
  description = "Index document for the website"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Error document for the website"
  type        = string
  default     = "error.html"
}

variable "website_files" {
  description = "Map of website files to upload. Key is the S3 key, value is an object with 'source' and 'content_type'"
  type = map(object({
    source       = string
    content_type = string
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default     = {}
}
