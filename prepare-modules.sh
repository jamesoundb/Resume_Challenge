#!/bin/bash

# Script to prepare, create, and publish Terraform modules to GitHub
# Usage: ./prepare-modules.sh [USERNAME]
# Requires: gh (GitHub CLI) authenticated

set -e

# Configuration
MODULES_DIR="modules"
OUTPUT_DIR="../terraform-modules"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Terraform Module Publisher - Automated GitHub Publishing     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo

# Verify gh CLI is installed and authenticated
if ! command -v gh &> /dev/null; then
    echo -e "${RED}✗ GitHub CLI (gh) is not installed. Install it first:${NC}"
    echo "  https://cli.github.com/"
    exit 1
fi

if ! gh auth status &> /dev/null; then
    echo -e "${RED}✗ GitHub CLI is not authenticated. Run: gh auth login${NC}"
    exit 1
fi

# Get GitHub username from gh CLI
GITHUB_USERNAME="${1:-$(gh api user --jq '.login')}"
echo -e "${GREEN}✓${NC} Authenticated as: ${BLUE}${GITHUB_USERNAME}${NC}"

# Module definitions
declare -A MODULES=(
    ["s3-static-website"]="S3 Static Website Hosting"
    ["lambda-dynamodb-api"]="Lambda Function with DynamoDB Access"
    ["api-gateway-lambda"]="API Gateway Lambda Integration"
    ["dynamodb-tables"]="DynamoDB Tables Management"
    ["cloudfront-s3-website"]="CloudFront Distribution with Route53"
)

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo -e "${GREEN}✓${NC} Output directory: $OUTPUT_DIR"
echo

# Process each module
for MODULE_NAME in "${!MODULES[@]}"; do
    MODULE_DESC="${MODULES[$MODULE_NAME]}"
    REPO_NAME="terraform-aws-${MODULE_NAME}"
    MODULE_PATH="${MODULES_DIR}/${MODULE_NAME}"
    OUTPUT_PATH="${OUTPUT_DIR}/${REPO_NAME}"
    
    echo -e "${BLUE}📦 Processing: ${MODULE_DESC}${NC}"
    echo "   Repository: ${REPO_NAME}"
    
    # Create module directory
    mkdir -p "$OUTPUT_PATH"
    
    # Copy module files
    cp -r "${MODULE_PATH}"/* "$OUTPUT_PATH/"
    
    # Create LICENSE file (MIT License)
    cat > "${OUTPUT_PATH}/LICENSE" << 'EOF'
MIT License

Copyright (c) 2026 James Wurbel

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
EOF
    
    # Create .gitignore
    cat > "${OUTPUT_PATH}/.gitignore" << 'EOF'
# Terraform files
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
.terraform.lock.hcl

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db
EOF
    
    # Create GitHub Actions workflow
    mkdir -p "${OUTPUT_PATH}/.github/workflows"
    cat > "${OUTPUT_PATH}/.github/workflows/terraform.yml" << 'EOF'
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

  tflint:
    name: TFLint
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v3

    - uses: terraform-linters/setup-tflint@v3
      with:
        tflint_version: latest

    - name: Init TFLint
      run: tflint --init

    - name: Run TFLint
      run: tflint -f compact
EOF
    
    # Initialize git repository, create GitHub repo, and push
    cd "$OUTPUT_PATH"
    
    if [ ! -d .git ]; then
        git init
        git branch -M main
    fi
    
    # Format Terraform files
    if command -v terraform &> /dev/null; then
        terraform fmt -recursive 2>/dev/null || true
    fi

    # Stage all files
    git add .
    git commit -m "Initial commit - ${MODULE_DESC} module" 2>/dev/null || true

    # Create GitHub repo if it doesn't exist, then push
    if gh repo view "${GITHUB_USERNAME}/${REPO_NAME}" &> /dev/null; then
        echo -e "${YELLOW}   ⚠ Repo ${REPO_NAME} already exists on GitHub${NC}"
        # Ensure remote is set
        git remote remove origin 2>/dev/null || true
        git remote add origin "https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
        git push -u origin main --force
    else
        echo -e "${BLUE}   → Creating GitHub repo: ${REPO_NAME}${NC}"
        gh repo create "${REPO_NAME}" \
            --public \
            --description "Terraform AWS module: ${MODULE_DESC}" \
            --source . \
            --remote origin \
            --push
    fi

    # Tag v1.0.0 release if it doesn't exist
    if ! git tag -l | grep -q "v1.0.0"; then
        git tag -a v1.0.0 -m "Initial release - ${MODULE_DESC}"
        git push origin v1.0.0
        echo -e "${GREEN}   ✓ Tagged v1.0.0${NC}"
    else
        echo -e "${YELLOW}   ⚠ Tag v1.0.0 already exists${NC}"
    fi

    cd - > /dev/null
    
    echo -e "${GREEN}   ✓ Published: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}${NC}"
    echo
done

echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║              ✓ All Modules Published to GitHub!               ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
echo
echo -e "${YELLOW}Published repositories:${NC}"
for MODULE_NAME in "${!MODULES[@]}"; do
    echo "  https://github.com/${GITHUB_USERNAME}/terraform-aws-${MODULE_NAME}"
done
echo
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Visit https://registry.terraform.io/ to publish modules"
echo "2. Sign in with GitHub → Publish → Module → Select each repo"
echo
echo -e "${GREEN}Done! 🚀${NC}"
