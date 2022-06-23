variable "access_key" {
  default = "${{ secrets.AWS_ACCESS_KEY_ID }}"
}

variable "secret_key" {
  default = "${{ secrets.AWS_SECRET_ACCESS_KEY }}"
}

variable "region" {
  default = "us-east-1"
}

variable "www_domain_name" {
  default = "www.jameswurbel.com"
}

variable "root_domain_name" {
  default = "jameswurbel.com"
}

variable "acl" {
  default = "public-read"
}

variable "s3_resume_source" {
  default = "/home/james/Atom/Web_Dev/HTML_Resume/index.html"
}

variable "s3_resume_key" {
  default = "index.html"
}

variable "bucket_name_statefile" {
  default = "jameswurbel.com-statefile-storage"
}

variable "tags" {
  default = "cloud-resume"
}

variable "zone_id" {
  default = "Z0671827KLHXTUPUVC91"
}

variable "bucket_name" {
  default = "www.jameswurbel.com"
}

variable "default_root_object" {
  default = "index.html"
}

variable "s3_javascript_key" {
  default = "apifetch_jameswurbel.js"
}

variable "s3_javascript_source" {
  default = "/home/james/Atom/Web_Dev/HTML_Resume/apifetch_jameswurbel.js"
}
