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
  # Configuration options
}
resource "aws_iam_user" "CloudFront" {
    name = "CloudFront"
  
}
output "user_arn" {
    value = aws_iam_user.CloudFront.*.arn
  
}
resource "aws_iam_policy" "CF-policy" {
  name        = "CF-policy"
  description = "CF"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1676179017583",
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "CF-attach" {
  user       = aws_iam_user.CloudFront.name
  policy_arn = aws_iam_policy.CF-policy.arn
}

resource "aws_iam_access_key" "CloudFront" {
  user = aws_iam_user.CloudFront.name
}

output "access_key" {
  value = aws_iam_access_key.CloudFront.id
   sensitive = true
}

output "secret_key" {
  value = aws_iam_access_key.CloudFront.secret
   sensitive = true
}
resource "aws_s3_bucket" "dev_site_bucket" {
  bucket = "dev-site-dearl"
}

