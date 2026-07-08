terraform {

  backend "s3" {

    bucket = "terraform-state-bucket"

    key = "dev/terraform.tfstate"

    region = "ap-south-1"

    dynamodb_table = "terraform-lock"

    deletion_protection = false

   backup_retention_period = 7

    encrypt = true

  }

}