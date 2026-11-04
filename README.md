# Infra as Code Pipeline

Automated infrastructure provisioning and CI/CD deployment using Terraform, Docker, AWS ECS Fargate, Amazon ECR, and GitHub Actions.

## Project Overview

This project demonstrates how to provision AWS infrastructure using Infrastructure as Code (IaC) and automate application deployment through a CI/CD pipeline.

Terraform manages the infrastructure, Docker packages the application, Amazon ECR stores container images, and Amazon ECS Fargate runs the application without requiring manual EC2 server management.

## Architecture

- **Terraform:** Provisions and manages AWS infrastructure through reusable modules.
- **Amazon VPC:** Provides network isolation, public subnets, routing, and security groups.
- **Application Load Balancer (ALB):** Distributes incoming HTTP traffic to healthy ECS tasks.
- **Amazon ECS Fargate:** Runs and manages containerized application tasks.
- **Amazon ECR:** Stores Docker images used by ECS deployments.
- **AWS IAM and GitHub OIDC:** Allow GitHub Actions to authenticate to AWS without storing long-lived AWS access keys.
- **Amazon CloudWatch:** Collects application logs, provides monitoring, and supports CPU alarms.
- **Amazon S3:** Stores Terraform remote state with encryption and versioning.
- **Amazon DynamoDB:** Provides Terraform state locking for coordinated infrastructure changes.
- **GitHub Actions:** Automates validation, Docker image publishing, Terraform planning, and deployment.

## Infrastructure Components

The Terraform configuration is organized into modules:

- **Networking:** VPC, Internet Gateway, public subnets, route table, and subnet associations.
- **Security:** Security groups controlling traffic between the ALB and ECS tasks.
- **Compute:** ECR repository, ECS cluster, task definition, ECS service, ALB, target group, and IAM execution role.
- **Monitoring:** CloudWatch log groups and CPU utilization alarm.

The ECS service uses AWS Fargate with configurable desired task count and CPU-based autoscaling.

## Environments

The project uses Terraform workspaces for:

- `dev`
- `staging`
- `prod`

Each environment has its own variable configuration under the `terraform/environments/` directory.

This approach helps keep infrastructure configuration consistent while separating environment-specific resources and settings.

## CI/CD Workflow

1. A pull request or code push triggers GitHub Actions.
2. Terraform formatting and validation checks run.
3. The Docker image is built from the application Dockerfile.
4. On push events, GitHub Actions authenticates to AWS using OIDC and pushes the image to Amazon ECR.
5. Terraform plans are generated for the Dev, Staging, and Production environments.
6. The Dev environment is deployed using Terraform.
7. Staging and Production deployment jobs apply their respective environment configurations.
8. The Production deployment uses the GitHub `production` environment for deployment control and approval, when configured with required reviewers.
9. ECS task status, ALB target health, and the application URL are used to verify deployment success.

## Security

- GitHub Actions uses OpenID Connect (OIDC) to assume AWS IAM roles.
- AWS credentials are provided through GitHub repository secrets and IAM role configuration.
- Terraform state is stored remotely in an encrypted, versioned S3 bucket.
- DynamoDB state locking helps prevent concurrent Terraform state modifications.
- The ALB security group permits HTTP traffic, while ECS task ingress is restricted to traffic from the ALB security group.
- ECR image scanning is enabled on image push.

## Monitoring and Scaling

- ECS container logs are sent to CloudWatch Logs.
- A CloudWatch alarm monitors ECS CPU utilization.
- ECS Service Auto Scaling uses average CPU utilization to adjust task capacity.
- The configured minimum and maximum task counts allow scaling according to workload.

## Prerequisites

- AWS account
- AWS CLI
- Terraform
- Docker
- Git and GitHub
- GitHub repository secrets:
  - `AWS_ROLE_ARN`
  - `AWS_TERRAFORM_ROLE_ARN`
- GitHub Actions OIDC provider and corresponding AWS IAM role trust policies

## Local Terraform Commands

Run these commands from the `terraform/` directory.

### Initialize Terraform

```bash
terraform init
```

### Select the Dev workspace

```bash
terraform workspace select dev
```

### Review infrastructure changes

```bash
terraform plan -var-file="environments/dev/dev.tfvars"
```

### Apply infrastructure changes

```bash
terraform apply -var-file="environments/dev/dev.tfvars"
```

Review the plan and expected AWS costs before applying changes.

### View Terraform outputs

```bash
terraform output
```

## Verification

- Confirm the ECS service has the expected running tasks.
- Confirm the ALB target group reports healthy targets.
- Open the ALB DNS URL to verify application access.
- Review application logs and monitoring alarms in CloudWatch.
- Verify the GitHub Actions workflow results for image publishing, planning, and deployment.

## Project Status

The Dev, Staging, and Production deployment workflows have been executed successfully. The Dev application was verified through the Application Load Balancer, with ECS tasks running and target health checks passing.