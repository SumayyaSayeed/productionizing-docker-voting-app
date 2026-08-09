terraform {

  backend "s3" {

    bucket = "terraform-state-245"

    key = "productionizing-docker-voting-app/terraform.tfstate"

    region = "ap-south-1"

    encrypt = true
  }
  # backend "local" {}
}