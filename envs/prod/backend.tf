terraform {

  backend "s3" {

    bucket = "terraform-state-bucket"

    key = "prod/terraform.tfstate"

    region = "ap-south-1"

    dynamodb_table = "terraform-lock"

    deletion_protection = true

    backup_retention_period = 15

    encrypt = true

  }

}