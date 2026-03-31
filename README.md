# Cloud Resume Challenge — Backend Infrastructure

Terraform root configuration for [jameswurbel.com](https://jameswurbel.com). This repo is a thin orchestration layer that calls versioned modules from the [HCP Terraform private registry](https://app.terraform.io/app/Jamesoundb).

![Cloud_Resume_Challenge](https://user-images.githubusercontent.com/20709997/176242750-afb7614f-3bb5-4e4a-9d90-7089a9a4719c.jpg)

## Architecture

```
Browser ─→ Route53 ─→ CloudFront ─→ S3 (static site)
                           │
                      API Gateway ─→ Lambda ─→ DynamoDB
```

All infrastructure is defined through five Terraform modules, each in its own repository:

| Module | Registry Source | Version |
|--------|----------------|---------|
| [dynamodb-tables](https://github.com/jamesoundb/terraform-aws-dynamodb-tables) | `app.terraform.io/Jamesoundb/dynamodb-tables/aws` | 1.0.2 |
| [s3-static-website](https://github.com/jamesoundb/terraform-aws-s3-static-website) | `app.terraform.io/Jamesoundb/s3-static-website/aws` | 1.0.0 |
| [lambda-dynamodb-api](https://github.com/jamesoundb/terraform-aws-lambda-dynamodb-api) | `app.terraform.io/Jamesoundb/lambda-dynamodb-api/aws` | 1.0.0 |
| [api-gateway-lambda](https://github.com/jamesoundb/terraform-aws-api-gateway-lambda) | `app.terraform.io/Jamesoundb/api-gateway-lambda/aws` | 1.0.0 |
| [cloudfront-s3-website](https://github.com/jamesoundb/terraform-aws-cloudfront-s3-website) | `app.terraform.io/Jamesoundb/cloudfront-s3-website/aws` | 1.0.1 |

## Repository Structure

```
├── main.tf                    # Module calls (registry sources)
├── variables.tf               # Input variables
├── outputs.tf                 # Root outputs
├── providers.tf               # AWS provider + S3 backend
├── github_oidc.tf             # GitHub Actions OIDC auth (keyless CI/CD)
├── s3_statefile.tf            # State bucket + encryption + versioning
├── dynamodb_statelock_iam.tf  # State lock table IAM
├── lambda/
│   └── lambda_function.zip    # Lambda deployment package
├── docs/
│   ├── ARCHITECTURE.md        # Infrastructure diagrams
│   └── QUICK_START.md         # Getting started guide
└── .github/workflows/
    └── terraform.yml          # CI/CD pipeline
```

## CI/CD

GitHub Actions pipeline on push to `main`:

1. **Format** — `terraform fmt`
2. **Init** — Downloads modules from HCP registry
3. **Plan** — Previews changes
4. **Apply** — Deploys to AWS

Authentication uses **GitHub OIDC** — no static AWS keys stored in secrets.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- AWS account with Route53 hosted zone
- HCP Terraform account (for private registry access)
- `~/.terraformrc` with HCP Terraform credentials:
  ```hcl
  credentials "app.terraform.io" {
    token = "your-hcp-token"
  }
  ```

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## AWS Resources

| Service | Purpose |
|---------|---------|
| S3 | Static website hosting, Terraform state storage |
| CloudFront | CDN with SSL/TLS |
| Route53 | DNS (jameswurbel.com + www) |
| ACM | SSL certificate |
| API Gateway | REST API for visitor counter |
| Lambda | Visitor count logic (Python) |
| DynamoDB | Visitor count + state lock tables |
| IAM | OIDC provider, Lambda roles, state lock roles |

## License

[MIT](LICENSE)
