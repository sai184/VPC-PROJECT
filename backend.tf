terraform {
  backend "s3" {
  
    bucket = "cbnna"
    key = "cbnn/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "terraform-lock"
    


    
  }
}

# here we are giving all config related to s3 bucket