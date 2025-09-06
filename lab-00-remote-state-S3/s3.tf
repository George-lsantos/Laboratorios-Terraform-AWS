# Fonte de dados para obter o ID da conta AWS, para o nome do bucket
data "aws_caller_identity" "current" {}

# Bucket S3 para armazenar o arquivo de estado do Terraform
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-remote-state-${data.aws_caller_identity.current.account_id}"

  # Habilita o controle de versão para manter o histórico de estados
  versioning {
    enabled = true
  }

  # Desabilita o acesso público para garantir a segurança
  acl = "private"
}

# Tabela DynamoDB para bloqueio de estado (state locking)
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock Table"
    Environment = "Dev"
  }
}