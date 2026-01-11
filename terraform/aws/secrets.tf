resource "aws_secretsmanager_secret" "app_secret" {
  name = "devops-app-secret-v2"
  description = "Application configuration secrets"
}

resource "aws_secretsmanager_secret_version" "app_secret_val" {
  secret_id     = aws_secretsmanager_secret.app_secret.id
  secret_string = jsonencode({"API_KEY" = var.db_password})
}

# Grant ECS execution role access to secrets
resource "aws_iam_role_policy" "ecs_secrets_access" {
  name = "devops-ecs-secrets-access-v2"
  role = aws_iam_role.ecs_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = aws_secretsmanager_secret.app_secret.arn
      }
    ]
  })
}
