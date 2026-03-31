# Cloud Resume Challenge - Terraform Modules

This repository contains **5 production-ready, reusable Terraform modules** for deploying a Cloud Resume Challenge infrastructure on AWS. These modules are designed to be published to the Terraform Registry for community use.

![Cloud_Resume_Challenge](https://user-images.githubusercontent.com/20709997/176242750-afb7614f-3bb5-4e4a-9d90-7089a9a4719c.jpg)

## 🎯 What's Inside

### 📦 Terraform Modules (Production-Ready)

1. **[s3-static-website](modules/s3-static-website/)** - S3 bucket for static website hosting
2. **[lambda-dynamodb-api](modules/lambda-dynamodb-api/)** - Lambda function with DynamoDB access
3. **[api-gateway-lambda](modules/api-gateway-lambda/)** - API Gateway with Lambda integration
4. **[dynamodb-tables](modules/dynamodb-tables/)** - DynamoDB table management
5. **[cloudfront-s3-website](modules/cloudfront-s3-website/)** - CloudFront CDN with Route53 DNS

Each module includes complete Terraform code, comprehensive documentation, usage examples, and best practices implementation.

### 📚 Comprehensive Documentation

- **[INDEX.md](INDEX.md)** ⭐ **START HERE** - Complete navigation guide
- **[QUICK_START.md](QUICK_START.md)** - Quick reference and getting started
- **[PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)** - Complete project overview
- **[ARCHITECTURE.md](ARCHITECTURE.md)** - Visual diagrams and architecture
- **[TERRAFORM_REGISTRY_GUIDE.md](TERRAFORM_REGISTRY_GUIDE.md)** - Publishing guide
- **[prepare-modules.sh](prepare-modules.sh)** - Automation script

### 🏗️ Infrastructure Architecture

```
User → Route53 → CloudFront → S3 (Static Website)
                      ↓
                 API Gateway → Lambda → DynamoDB
```

## 🚀 Quick Start

### Test Locally
```bash
cd /home/james/Cloud_Resume_Challenge_2
cp main-example.tf test-main.tf
terraform init && terraform plan
```

### Prepare for Publishing
```bash
./prepare-modules.sh YOUR_GITHUB_USERNAME
```

### Use Modules Locally
```hcl
module "website" {
  source = "./modules/s3-static-website"
  bucket_name = "www.example.com"
  website_files = {
    "index.html" = {
      source       = "path/to/index.html"
      content_type = "text/html"
    }
  }
}
```

## 📖 Documentation

**New to this project?** → [INDEX.md](INDEX.md)  
**Want to publish?** → [TERRAFORM_REGISTRY_GUIDE.md](TERRAFORM_REGISTRY_GUIDE.md)  
**Need architecture overview?** → [ARCHITECTURE.md](ARCHITECTURE.md)  

## ✨ Features

- ✅ **5 reusable modules** ready for Terraform Registry
- ✅ **Complete documentation** (~10,000 words)
- ✅ **Automation tooling** for easy publishing
- ✅ **Production-ready** with best practices

## 🎓 Resources

**Original Resources Include:**
1. API Gateway
2. CloudFront
3. DynamoDB
4. Lambda Function
5. Route53
6. S3 for static website
7. S3 for tfstate storage
8. ACM Certificate
9. IAM Policies

**Now Organized Into 5 Reusable Modules!**

## 🌐 Deployment

Infrastructure deployed at: [jameswurbel.com](https://jameswurbel.com)

---

**Ready to get started?** 👉 [INDEX.md](INDEX.md)  
**Want to publish?** 👉 [TERRAFORM_REGISTRY_GUIDE.md](TERRAFORM_REGISTRY_GUIDE.md)
