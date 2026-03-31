# Cloud Resume Challenge - Terraform Modules

This repository contains modular, reusable Terraform configurations for deploying a Cloud Resume Challenge infrastructure on AWS.

## 🏗️ Architecture

The infrastructure is broken down into five independent, reusable modules:

1. **s3-static-website** - S3 bucket for static website hosting
2. **lambda-dynamodb-api** - Lambda function with DynamoDB access
3. **api-gateway-lambda** - API Gateway integrated with Lambda
4. **dynamodb-tables** - DynamoDB table management
5. **cloudfront-s3-website** - CloudFront distribution with Route53 and ACM

## 📦 Module Structure

```
Cloud_Resume_Challenge_2/
├── modules/
│   ├── s3-static-website/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── lambda-dynamodb-api/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── api-gateway-lambda/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── dynamodb-tables/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   └── cloudfront-s3-website/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── README.md
├── main-example.tf          # Example usage of all modules
├── outputs-example.tf       # Example outputs
├── TERRAFORM_REGISTRY_GUIDE.md
└── README.md
```

## 🚀 Quick Start

### Using the Modules Locally

```hcl
module "s3_website" {
  source = "./modules/s3-static-website"

  bucket_name = "www.example.com"
  
  website_files = {
    "index.html" = {
      source       = "/path/to/index.html"
      content_type = "text/html"
    }
  }
}
```

### Using Published Modules (After Publishing)

```hcl
module "s3_website" {
  source  = "YOUR_USERNAME/s3-static-website/aws"
  version = "1.0.0"

  bucket_name = "www.example.com"
  # ... other variables
}
```

## 📚 Module Documentation

Each module has its own comprehensive README with:
- Features and capabilities
- Usage examples
- Input variables
- Output values
- Requirements

See individual module directories for detailed documentation.

## 🔄 Module Interdependencies

The modules are designed to work together:

```
DynamoDB Tables ──→ Lambda Function ──→ API Gateway
                                          ↓
S3 Website ──────→ CloudFront ←──────────┘
     ↓
Route53 Records
```

Example workflow:
1. Create DynamoDB tables
2. Deploy Lambda function with DynamoDB access
3. Set up API Gateway to invoke Lambda
4. Create S3 bucket with website content
5. Configure CloudFront with Route53

## 📋 Prerequisites

- Terraform >= 1.0
- AWS Provider >= 4.0
- AWS Account with appropriate permissions
- Route53 hosted zone (for CloudFront module)
- Domain name

## 🎯 Complete Example

See [main-example.tf](main-example.tf) for a complete example that uses all modules together.

To use the example:

```bash
# Copy example files
cp main-example.tf main.tf
cp outputs-example.tf outputs.tf

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply the configuration
terraform apply
```

## 📦 Publishing to Terraform Registry

Want to publish these modules to the Terraform Registry? See the comprehensive guide:

**[📖 Terraform Registry Publishing Guide](TERRAFORM_REGISTRY_GUIDE.md)**

The guide covers:
- Repository setup and naming conventions
- Required files and structure
- GitHub Actions for CI/CD
- Versioning and tagging
- Publishing workflow
- Best practices

## 🔐 Security Considerations

- S3 buckets use public-read ACL for website hosting
- Lambda functions have minimal IAM permissions
- CloudFront enforces HTTPS
- DynamoDB tables support encryption at rest
- All modules support resource tagging

## 🏷️ Tagging Strategy

All modules support tags for resource organization:

```hcl
tags = {
  Project     = "CloudResume"
  Environment = "production"
  ManagedBy   = "Terraform"
  Owner       = "james"
}
```

## 🔧 Customization

Each module is highly configurable:

- **S3**: Custom ACLs, multiple files, content types
- **Lambda**: Runtime, memory, timeout, environment variables
- **API Gateway**: HTTP methods, CORS settings, stages
- **DynamoDB**: Billing modes, GSI, encryption
- **CloudFront**: Cache behaviors, geo-restrictions, price class

## 📊 Outputs

The example configuration provides comprehensive outputs:

- DynamoDB table names and ARNs
- S3 bucket IDs and endpoints
- Lambda function details
- API Gateway invoke URLs
- CloudFront distribution details
- Website URL

## 🧪 Testing

Before publishing, test your modules:

```bash
# Format code
terraform fmt -recursive

# Validate configuration
cd modules/s3-static-website
terraform init
terraform validate

# Repeat for each module
```

## 🤝 Contributing

If you publish these modules:

1. Accept issues and pull requests
2. Maintain semantic versioning
3. Document breaking changes
4. Provide migration guides
5. Keep README files updated

## 📝 License

When publishing to the Terraform Registry, add an open-source license (MIT, Apache 2.0, etc.).

## 🔗 Resources

- [Terraform Module Documentation](https://www.terraform.io/docs/language/modules/develop/index.html)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Registry](https://registry.terraform.io/)

## 💡 Next Steps

1. **Local Development**: Test modules with `main-example.tf`
2. **Repository Setup**: Create GitHub repos for each module
3. **CI/CD**: Add GitHub Actions for validation
4. **Publishing**: Follow the [Terraform Registry Guide](TERRAFORM_REGISTRY_GUIDE.md)
5. **Maintenance**: Monitor usage and respond to issues

## 📞 Support

For questions about:
- **Module Usage**: See individual module README files
- **Publishing**: See [TERRAFORM_REGISTRY_GUIDE.md](TERRAFORM_REGISTRY_GUIDE.md)
- **AWS Resources**: Check AWS documentation

---

**Happy Terraforming! 🚀**
