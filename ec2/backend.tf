terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Update the bucket name to an S3 bucket you already own.
  # If you don't have one yet, comment out this whole backend block
  # to use local state instead (fine for testing, not for team use).
  backend "s3" {
    bucket = "ssstfstate"
    key    = "ec2/ec2.tfstate"
    region = "us-west-2"
  }
}
