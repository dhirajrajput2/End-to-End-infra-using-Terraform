terraform {
  backend "s3" {
    bucket         = "project1-terraform-state-dhiraj-001"
    key            = "project1/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
