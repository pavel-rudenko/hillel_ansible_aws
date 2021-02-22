terraform {
  required_version = "~> 0.14"
  required_providers {
    aws = {
      version = "~> 3.21"
    }
  }
}
provider "aws" {
  profile = "newtest"
  region  = "us-east-1"
}