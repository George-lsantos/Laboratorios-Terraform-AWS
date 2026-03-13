terraform {
		#Criação Remote State
		  backend "s3" {
		    bucket         = "terraform-states-my-george"   # Bucket no S3
		    key            = "infra/dev/terraform.tfstate"  # Caminho/arquivo dentro do bucket
		    region         = "us-east-1"              # Região do bucket
		    /*dynamodb_table = "terraform-locks"        # Tabela DynamoDB usada para lock */
		  }
		}
