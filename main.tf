terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = "AKIA54IWJK2GYYW7235J"
  secret_key = "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"
}

resource "aws_iam_user" "CloudFront" {
  name = "CloudFront"
}

output "user_arn" {
  value = aws_iam_user.CloudFront.arn
}

resource "aws_iam_policy" "CF-policy" {
  name        = "CF-policy"
  description = "CF"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "Stmt1676179017583"
        Action = "*"
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "CF-attach" {
  user       = aws_iam_user.CloudFront.name
  policy_arn = aws_iam_policy.CF-policy.arn
}

resource "aws_iam_access_key" "CloudFront" {
  user = aws_iam_user.CloudFront.name
}

output "access_key" {
  value     = aws_iam_access_key.CloudFront.id
  sensitive = true
}

output "secret_key" {
  value     = aws_iam_access_key.CloudFront.secret
  sensitive = true
}

resource "aws_s3_bucket" "dev_site_bucket" {
  bucket = "dev-site-dearl"
}

resource "aws_iam_user" "GitHub-Actions" {
  name = "GitHub-Actions"
}

output "user_arn2" {
  value = aws_iam_user.GitHub-Actions.arn
}

resource "aws_iam_policy" "gh-policy" {
  name        = "gh-policy"
  description = "Git Hub Action Policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "VisualEditor0"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:ListBucket",
          "cloudfront:CreateInvalidation"
        ]
        Resource = [
          "arn:aws:cloudfront::954066359949:distribution/EIWSN5GE1AVDT",
          "arn:aws:s3:::dev-site-dearl/*",
          "arn:aws:s3:::dev-site-dearl"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "GH-attach" {
  user       = aws_iam_user.GitHub-Actions.name
  policy_arn = aws_iam_policy.gh-policy.arn
}

resource "aws_iam_access_key" "GitHub-Actions-Key" {
  user = aws_iam_user.GitHub-Actions.name
}

output "access_key2" {
  value     = aws_iam_access_key.GitHub-Actions-Key.id
  sensitive = true
}

output "secret_key2" {
  value     = aws_iam_access_key.GitHub-Actions-Key.secret
  sensitive = true
}
