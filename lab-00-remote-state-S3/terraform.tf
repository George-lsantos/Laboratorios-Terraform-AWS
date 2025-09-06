terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.92" 
    }
}
   backend "s3" {
			    bucket         = "terraform-remote-state-029718549911"  # Substitua pelo seu ID de conta
			    key            = "dev/meu-projeto/terraform.tfstate"
			    region         = "us-east-1"
			    dynamodb_table = "terraform-lock"
			    encrypt        = true
			  }

}