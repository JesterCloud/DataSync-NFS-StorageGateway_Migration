terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = "AKIA6GBMF7DVWQ4E465M"
  secret_key = "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"
}