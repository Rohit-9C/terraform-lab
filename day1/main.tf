terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }


provider "local" {}

variable "message" {
  description = "Message written to the file"
  type        = string
  default     = "Hello from Terraform"
}

resource "local_file" "hello_file" {
  filename = "hello.txt"
  content  = var.message
}

output "file_path" {
  value = local_file.hello_file.filename
}
