# Publishing Modules to Terraform Registry - Guide

This guide walks you through the process of publishing your Terraform modules to the public Terraform Registry.

## Prerequisites

1. **GitHub Account**: All public modules must be hosted on GitHub
2. **Module Repositories**: Each module should be in its own GitHub repository
3. **Naming Convention**: Repository names must follow the pattern: `terraform-<PROVIDER>-<NAME>`

## Repository Structure

Each module repository should have this structure:

```
terraform-aws-module-name/
├── README.md           # Module documentation (required)
├── main.tf            # Main resources
├── variables.tf       # Input variables
├── outputs.tf         # Output values
├── versions.tf        # Terraform and provider version constraints
├── LICENSE            # License file (required)
├── examples/          # Usage examples (recommended)
│   └── complete/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── .github/
    └── workflows/
        └── terraform.yml  # CI/CD workflow
```

## Step-by-Step Publishing Process

### 1. Prepare Each Module Repository

For each module, create a separate GitHub repository:

#### Module: S3 Static Website
- Repository: `terraform-aws-s3-static-website`
- Source: `modules/s3-static-website/`

#### Module: Lambda DynamoDB API
- Repository: `terraform-aws-lambda-dynamodb-api`
- Source: `modules/lambda-dynamodb-api/`

#### Module: API Gateway Lambda
- Repository: `terraform-aws-api-gateway-lambda`
- Source: `modules/api-gateway-lambda/`

#### Module: DynamoDB Tables
- Repository: `terraform-aws-dynamodb-tables`
- Source: `modules/dynamodb-tables/`

#### Module: CloudFront S3 Website
- Repository: `terraform-aws-cloudfront-s3-website`
- Source: `modules/cloudfront-s3-website/`

### 2. Add Required Files to Each Repository

#### versions.tf (add to each module)

```hcl
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}
```

#### LICENSE (add to each module)

Choose an open-source license (MIT, Apache 2.0, etc.). Example for MIT:

```
MIT License

Copyright (c) 2026 Your Name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

### 3. Create GitHub Repositories

For each module:

```bash
# Example for S3 Static Website module
cd /path/to/your/modules/s3-static-website

# Initialize git
git init

# Add remote repository
git remote add origin https://github.com/YOUR_USERNAME/terraform-aws-s3-static-website.git

# Add all files
git add .

# Commit
git commit -m "Initial commit - S3 Static Website module"

# Push to GitHub
git branch -M main
git push -u origin main
```

### 4. Create Git Tags for Versioning

Terraform Registry uses Git tags for versioning. Use semantic versioning (MAJOR.MINOR.PATCH):

```bash
# Create and push a version tag
git tag -a v1.0.0 -m "Initial release"
git push origin v1.0.0
```

### 5. Sign in to Terraform Registry

1. Go to https://registry.terraform.io/
2. Click "Sign In" and authenticate with GitHub
3. Authorize Terraform Registry to access your GitHub account

### 6. Publish Modules

1. Click "Publish" in the top navigation
2. Select "Module"
3. Choose the GitHub repository for your module
4. The registry will automatically detect the module and validate it
5. Agree to the terms of service
6. Click "Publish Module"

The registry will:
- Validate your module structure
- Generate documentation from your README
- Create a module page with usage examples
- Make it searchable in the registry

### 7. Module Discovery

Once published, your modules will be available at:
- `registry.terraform.io/YOUR_USERNAME/s3-static-website/aws`
- `registry.terraform.io/YOUR_USERNAME/lambda-dynamodb-api/aws`
- etc.

### 8. Using Published Modules

After publishing, you can use your modules like this:

```hcl
module "s3_website" {
  source  = "YOUR_USERNAME/s3-static-website/aws"
  version = "1.0.0"

  bucket_name = "my-website-bucket"
  # ... other variables
}
```

## Best Practices

### Documentation
- Write clear, comprehensive README files
- Include usage examples
- Document all input variables and outputs
- Add badges for build status, version, etc.

### Versioning
- Use semantic versioning
- Tag releases properly
- Maintain a CHANGELOG.md file
- Don't delete tags/releases

### Testing
- Add examples in `examples/` directory
- Set up automated testing with Terratest
- Use GitHub Actions for CI/CD
- Test with multiple Terraform versions

### Quality
- Use consistent formatting (`terraform fmt`)
- Validate configurations (`terraform validate`)
- Run security scans (tfsec, checkov)
- Keep modules focused and single-purpose

## GitHub Actions Workflow Example

Create `.github/workflows/terraform.yml`:

```yaml
name: Terraform Module CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  terraform:
    name: Terraform Validation
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v3

    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v2
      with:
        terraform_version: 1.6.0

    - name: Terraform Format Check
      run: terraform fmt -check -recursive

    - name: Terraform Init
      run: terraform init

    - name: Terraform Validate
      run: terraform validate
```

## Module Maintenance

After publishing:
- Respond to issues and pull requests
- Release updates with new tags
- Monitor usage statistics in the registry
- Keep documentation up to date
- Address security vulnerabilities promptly

## Private Registry Alternative

If you prefer to keep modules private, consider:
- **Terraform Cloud/Enterprise**: Private module registry
- **GitHub Releases**: Use Git tags and reference directly
- **S3/GCS**: Host module archives
- **Private Git Repositories**: Reference with Git URLs

Example with private Git:
```hcl
module "s3_website" {
  source = "git::https://github.com/YOUR_ORG/terraform-aws-s3-static-website.git?ref=v1.0.0"
  # ... variables
}
```

## Resources

- [Terraform Registry Documentation](https://www.terraform.io/docs/registry/index.html)
- [Publishing Modules](https://www.terraform.io/docs/registry/modules/publish.html)
- [Module Standards](https://www.terraform.io/docs/language/modules/develop/index.html)
- [Semantic Versioning](https://semver.org/)
