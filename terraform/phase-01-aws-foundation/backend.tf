terraform {
  backend "s3" {
    bucket         = "alpensec-security-lab-dev-tfstate-472716449337"
    key            = "phase-01-aws-foundation/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "alpensec-security-lab-dev-terraform-locks"
    encrypt        = true
  }
}