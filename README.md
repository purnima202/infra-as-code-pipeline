# Infra as Code Pipeline

Automated infrastructure provisioning and application deployment using Terraform, Docker, AWS ECS Fargate, Amazon ECR, and GitHub Actions.

## Project Overview

This project demonstrates Infrastructure as Code (IaC) and CI/CD automation for deploying a containerized web application to AWS.

## Architecture

- **Terraform:** Provisions and manages AWS infrastructure.
- **Amazon VPC:** Network, public subnets, routes, and security groups.
- **Amazon ECS Fargate:** Runs the application containers.
- **Application Load Balancer:** Routes HTTP traffic to healthy ECS tasks.
- **Amazon ECR:** Stores Docker images.
- **Amazon CloudWatch:** Collects application logs and monitors CPU utilization.
- **GitHub Actions:** Automates validation, image publishing, Terraform planning, and deployment.
- **S3 backend and DynamoDB:** Store Terraform state remotely and support state locking.

## Environments

The project uses Terraform workspaces for `dev`, `staging`, and `prod`, with environment-specific variable files.

## CI/CD Workflow

1. A code push triggers GitHub Actions.
2. Terraform formatting and validation run.
3. The Docker image is built.
4. The image is pushed to Amazon ECR.
5. Terraform plans are generated for the configured environments.
6. The Dev environment is deployed automatically.
7. Staging and Production deployments can be run through their deployment jobs; Production should require approval.
8. ECS and the Application Load Balancer are used to verify application availability.

## Security

- GitHub Actions authenticates to AWS using OIDC.
- AWS permissions are assigned through IAM roles.
- Terraform state is stored in an encrypted S3 backend.
- ECS tasks accept application traffic through the ALB security group.
- Container images are scanned on push.

## Prerequisites

- AWS account and AWS CLI
- Terraform
- Docker
- Git and GitHub
- GitHub repository secrets `AWS_ROLE_ARN` and `AWS_TERRAFORM_ROLE_ARN`
- An AWS OIDC identity provider configured for GitHub Actions

## Local Terraform Commands

Run these commands from the `terraform` directory.

Initialize Terraform:

```bash
terraform init
```

Select the Dev workspace:

```bash
terraform workspace select dev
```

Review the plan:

```bash
terraform plan -var-file="environments/dev/dev.tfvars"
```

Apply changes only after reviewing the plan and expected AWS costs:

```bash
terraform apply -var-file="environments/dev/dev.tfvars"
```

View outputs:

```bash
terraform output
```

## Verification

- Confirm ECS tasks are running.
- Confirm the ALB target group reports healthy targets.
- Open the ALB URL in a browser.
- Review application logs and alarms in CloudWatch.
- Verify GitHub Actions workflow results.