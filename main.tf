terraform {
  cloud {
    organization = "bcbrookman"

    workspaces {
      name = "f5-lab"
    }
  }
  required_providers {
    aws = {
    source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}
