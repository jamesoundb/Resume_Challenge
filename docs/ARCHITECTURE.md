# Terraform Modules Architecture

## 📦 Module Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                           Cloud Resume                          │
│                   Terraform Module Architecture                 │
└─────────────────────────────────────────────────────────────────┘

┌──────────────────────┐
│   User Requests      │
│   via Browser        │
└──────────┬───────────┘
           │
           ↓
┌──────────────────────────────────────────────────────────┐
│  CloudFront + Route53 Module                              │
│  ┌────────────────────────────────────────────────────┐  │
│  │ • ACM Certificate (SSL/TLS)                        │  │
│  │ • CloudFront Distribution                          │  │
│  │ • Route53 DNS Records (A records)                  │  │
│  │ • Origin Access Identity                           │  │
│  └────────────────────────────────────────────────────┘  │
└──────────┬────────────────────────────────┬──────────────┘
           │                                │
           │ (HTTPS)                        │
           ↓                                ↓
┌──────────────────────┐         ┌──────────────────────┐
│  S3 Website Module   │         │  API Gateway Module  │
│  ┌────────────────┐  │         │  ┌────────────────┐  │
│  │ • S3 Bucket    │  │         │  │ • REST API     │  │
│  │ • Website      │  │         │  │ • Resources    │  │
│  │   Config       │  │         │  │ • Methods      │  │
│  │ • Static Files │  │         │  │ • CORS         │  │
│  │ • ACL          │  │         │  │ • Stage        │  │
│  └────────────────┘  │         │  └────────────────┘  │
└──────────────────────┘         └──────────┬───────────┘
                                            │
       HTML/CSS/JS                          │ (Invoke)
       Resume Content                       ↓
                                 ┌──────────────────────────┐
                                 │  Lambda + DynamoDB Module│
                                 │  ┌────────────────────┐  │
                                 │  │ • Lambda Function  │  │
                                 │  │ • IAM Role/Policy  │  │
                                 │  │ • Permissions      │  │
                                 │  │ • Environment Vars │  │
                                 │  └─────────┬──────────┘  │
                                 └────────────┼─────────────┘
                                              │
                                              │ (Read/Write)
                                              ↓
                                 ┌──────────────────────────┐
                                 │  DynamoDB Tables Module  │
                                 │  ┌────────────────────┐  │
                                 │  │ • Visitors Table   │  │
                                 │  │ • State Lock Table │  │
                                 │  │ • Encryption       │  │
                                 │  │ • Billing Config   │  │
                                 │  └────────────────────┘  │
                                 └──────────────────────────┘
```

## 🔄 Data Flow

```
User Request Flow:
1. User visits www.jameswurbel.com
2. Route53 routes to CloudFront
3. CloudFront serves static content from S3
4. JavaScript makes API call to API Gateway
5. API Gateway invokes Lambda function
6. Lambda reads/updates visitor count in DynamoDB
7. Response flows back through the stack
```

## 📂 Module Structure

```
Cloud_Resume/
│
├── modules/                                    # All reusable modules
│   │
│   ├── s3-static-website/                     # Module 1: S3 Website
│   │   ├── main.tf                            # S3 bucket, ACL, config
│   │   ├── variables.tf                       # bucket_name, files, etc.
│   │   ├── outputs.tf                         # bucket_id, endpoint
│   │   ├── versions.tf                        # Terraform/provider versions
│   │   └── README.md                          # Documentation
│   │
│   ├── lambda-dynamodb-api/                   # Module 2: Lambda + IAM
│   │   ├── main.tf                            # Lambda, IAM role/policy
│   │   ├── variables.tf                       # function_name, runtime, etc.
│   │   ├── outputs.tf                         # function_arn, invoke_arn
│   │   ├── versions.tf                        # Version constraints
│   │   └── README.md                          # Documentation
│   │
│   ├── api-gateway-lambda/                    # Module 3: API Gateway
│   │   ├── main.tf                            # REST API, resources, methods
│   │   ├── variables.tf                       # api_name, cors, etc.
│   │   ├── outputs.tf                         # api_id, invoke_url
│   │   ├── versions.tf                        # Version constraints
│   │   └── README.md                          # Documentation
│   │
│   ├── dynamodb-tables/                       # Module 4: DynamoDB
│   │   ├── main.tf                            # DynamoDB tables
│   │   ├── variables.tf                       # table definitions
│   │   ├── outputs.tf                         # table_arns, names
│   │   ├── versions.tf                        # Version constraints
│   │   └── README.md                          # Documentation
│   │
│   └── cloudfront-s3-website/                 # Module 5: CloudFront + DNS
│       ├── main.tf                            # CloudFront, ACM, Route53
│       ├── variables.tf                       # domain_name, aliases, etc.
│       ├── outputs.tf                         # distribution_id, url
│       ├── versions.tf                        # Version constraints
│       └── README.md                          # Documentation
│
├── main-example.tf                            # Example using all modules
├── outputs-example.tf                         # Example outputs
├── variables.tf                               # Root variables
├── providers.tf                               # Provider configuration
│
├── QUICK_START.md                             # 👈 Start here!
├── MODULE_README.md                           # Module overview
├── TERRAFORM_REGISTRY_GUIDE.md                # Publishing guide
├── prepare-modules.sh                         # 🚀 Automation script
│
└── lambda/                                    # Lambda function code
    └── lambda_function.zip                    # Deployment package
```

## 🎯 Module Relationships

```
┌─────────────────────────────────────────────────────────────┐
│                     Module Dependencies                       │
└─────────────────────────────────────────────────────────────┘

Independent Modules (can be used standalone):
  ├─ dynamodb-tables          (no dependencies)
  ├─ s3-static-website        (no dependencies)
  └─ lambda-dynamodb-api      (no dependencies)

Dependent Modules (require outputs from other modules):
  ├─ api-gateway-lambda       (requires: lambda invoke_arn)
  └─ cloudfront-s3-website    (requires: s3 domain_name, route53 zone)

Integration Example:
  DynamoDB → Lambda → API Gateway
      ↓
      S3 → CloudFront → Route53
```

## 🔑 Key Features by Module

### 1️⃣ S3 Static Website
- ✅ Website hosting configuration
- ✅ Multiple file upload support
- ✅ ACL management
- ✅ Content type handling
- ✅ Automatic index/error docs

### 2️⃣ Lambda + DynamoDB API
- ✅ Lambda function deployment
- ✅ IAM role/policy creation
- ✅ DynamoDB access permissions
- ✅ API Gateway invoke permissions
- ✅ Environment variables
- ✅ CloudWatch Logs integration

### 3️⃣ API Gateway Lambda
- ✅ REST API creation
- ✅ CORS configuration
- ✅ Lambda integration
- ✅ Deployment stages
- ✅ Method responses
- ✅ Automatic redeployment

### 4️⃣ DynamoDB Tables
- ✅ Multiple table support
- ✅ Flexible billing modes
- ✅ Global Secondary Indexes
- ✅ Encryption at rest
- ✅ Point-in-time recovery
- ✅ Attribute definitions

### 5️⃣ CloudFront + Route53
- ✅ ACM certificate (SSL/TLS)
- ✅ DNS validation
- ✅ CloudFront distribution
- ✅ Origin Access Identity
- ✅ Cache behaviors
- ✅ Geographic restrictions
- ✅ Route53 A records
- ✅ IPv6 support

## 📊 Input/Output Flow

```
Module: s3-static-website
  Inputs:  bucket_name, website_files
  Outputs: bucket_id, bucket_regional_domain_name
           ↓
Module: cloudfront-s3-website
  Inputs:  s3_bucket_regional_domain_name, domain_name
  Outputs: cloudfront_domain_name, website_url

────────────────────────────────────────────────

Module: dynamodb-tables
  Inputs:  tables (map of table definitions)
  Outputs: table_arns, table_names
           ↓
Module: lambda-dynamodb-api
  Inputs:  dynamodb_table_arns, function_name
  Outputs: invoke_arn, function_arn
           ↓
Module: api-gateway-lambda
  Inputs:  lambda_invoke_arn, api_name
  Outputs: invoke_url, api_execution_arn
```

## 🚀 Publishing Strategy

```
┌────────────────────────────────────────────────────────┐
│  Single Repository (Current)                           │
│  ├─ modules/                                           │
│  │  ├─ s3-static-website/                             │
│  │  ├─ lambda-dynamodb-api/                           │
│  │  ├─ api-gateway-lambda/                            │
│  │  ├─ dynamodb-tables/                               │
│  │  └─ cloudfront-s3-website/                         │
└────────────────────────────────────────────────────────┘
                        │
                        │ prepare-modules.sh
                        ↓
┌────────────────────────────────────────────────────────┐
│  Multiple Repositories (For Publishing)                │
│  ├─ terraform-aws-s3-static-website                   │
│  ├─ terraform-aws-lambda-dynamodb-api                 │
│  ├─ terraform-aws-api-gateway-lambda                  │
│  ├─ terraform-aws-dynamodb-tables                     │
│  └─ terraform-aws-cloudfront-s3-website               │
└────────────────────────────────────────────────────────┘
                        │
                        │ Push to GitHub + Tag
                        ↓
┌────────────────────────────────────────────────────────┐
│  Terraform Registry                                    │
│  https://registry.terraform.io/                        │
│  ├─ YOUR_USERNAME/s3-static-website/aws               │
│  ├─ YOUR_USERNAME/lambda-dynamodb-api/aws             │
│  ├─ YOUR_USERNAME/api-gateway-lambda/aws              │
│  ├─ YOUR_USERNAME/dynamodb-tables/aws                 │
│  └─ YOUR_USERNAME/cloudfront-s3-website/aws           │
└────────────────────────────────────────────────────────┘
```

## 📈 Versioning

```
v1.0.0 → Initial Release
  ├─ Basic functionality
  ├─ Core features
  └─ Documentation

v1.1.0 → Feature Addition
  ├─ New optional variables
  ├─ Enhanced outputs
  └─ Backward compatible

v2.0.0 → Breaking Changes
  ├─ Renamed variables
  ├─ Changed resource structure
  └─ Migration guide needed
```

## 🎓 Usage Levels

### Level 1: Local Development
```hcl
module "website" {
  source = "./modules/s3-static-website"
  # ... variables
}
```

### Level 2: Git Reference
```hcl
module "website" {
  source = "git::https://github.com/user/repo.git//modules/s3-static-website?ref=v1.0.0"
  # ... variables
}
```

### Level 3: Terraform Registry
```hcl
module "website" {
  source  = "username/s3-static-website/aws"
  version = "1.0.0"
  # ... variables
}
```

---

**Legend:**
- 📦 Modules
- 🔄 Data Flow
- 🎯 Features
- 🚀 Publishing
- 📈 Versioning
