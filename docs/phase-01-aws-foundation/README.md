# Phase 01 – AWS Foundation

## Project Overview

The goal of Phase 01 was to build a secure and scalable AWS foundation that will support all later phases of the Enterprise Security Lab.

This phase focuses on:

- Infrastructure as Code (Terraform)
- Secure state management
- Network segmentation
- Compute infrastructure
- Security Groups
- AWS best practices
- Reproducible deployments

The resulting environment serves as the foundation for:

- FreeIPA Identity Management
- Kubernetes Platform
- DevSecOps Pipeline
- Wazuh SIEM
- Prometheus & Grafana
- Vulnerability Management
- Incident Response

---

# Business Scenario

For this project, a fictional company called **AlpenSec Systems GmbH** was created.

AlpenSec is a security-focused technology company that requires:

- Centralized identity management
- Secure infrastructure deployment
- Network segmentation
- Security monitoring
- Containerized workloads
- Infrastructure automation

The objective is to design an enterprise-style cloud environment using modern DevSecOps principles.

---

# Architecture Overview

```text
Internet
    │
    ▼
security-01
(Public Subnet)
    │
    ▼
Private Network
├── freeipa-01
└── workload-01
```

---

# Project Objectives

The following goals were completed:

- AWS account preparation
- Terraform configuration
- Remote Terraform state backend
- State locking implementation
- Dedicated VPC deployment
- Public subnet deployment
- Private subnet deployment
- Internet Gateway deployment
- Route Table configuration
- Security Group implementation
- EC2 provisioning
- SSH validation
- Terraform code refactoring

---

# Terraform Backend

## Why a Remote Backend?

Terraform stores infrastructure information inside a state file.

Without a remote backend:

- State exists only on the local workstation
- Team collaboration becomes difficult
- State can be lost
- Infrastructure drift becomes harder to detect

To solve this, a remote backend was implemented.

---

## Amazon S3

Purpose:

- Central state storage
- Versioning support
- Persistent storage
- Recovery capability

Resource:

```text
alpensec-security-lab-dev-tfstate-<account-id>
```

---

## DynamoDB State Locking

Purpose:

- Prevent concurrent Terraform executions
- Prevent state corruption
- Ensure deployment consistency

Resource:

```text
alpensec-security-lab-dev-terraform-locks
```

---

# Network Design

## Virtual Private Cloud (VPC)

CIDR:

```text
10.10.0.0/16
```

Purpose:

- Dedicated AWS network
- Isolation from default AWS resources
- Full routing control
- Enterprise-style architecture

---

## Public Subnet

CIDR:

```text
10.10.1.0/24
```

Purpose:

- Internet-facing systems
- Monitoring platform access
- Public services

---

## Private Subnet

CIDR:

```text
10.10.2.0/24
```

Purpose:

- Internal services
- Identity infrastructure
- Application workloads

Keeping sensitive systems in private networks reduces the attack surface.

---

## Internet Gateway

Purpose:

- Connect VPC resources to the Internet
- Enable external communication

Without an Internet Gateway, systems inside the VPC would not have Internet access.

---

## Route Tables

Configured Route:

```text
0.0.0.0/0 -> Internet Gateway
```

Purpose:

- Route external traffic correctly
- Enable connectivity for resources inside the public subnet

---

# Network Architecture Screenshot

```md
screenshots/phase-01-aws-foundation/vpc-resource-map.png
```

![VPC Resource Map](../../../screenshots/phase-01-aws-foundation/vpc-resource-map.png)

This view shows:

- Custom VPC
- Public subnet
- Private subnet
- Route tables
- Internet Gateway

---

# Security Design

## Security Groups

Security Groups function as cloud firewalls.

Each server receives its own security policy.

---

## Management Security Group

Used for:

```text
freeipa-01
```

Allowed:

```text
22 SSH
80 HTTP
443 HTTPS
```

---

## Security Security Group

Used for:

```text
security-01
```

Allowed:

```text
22 SSH
443 HTTPS
3000 Grafana
5601 Wazuh Dashboard
```

---

## Workload Security Group

Used for:

```text
workload-01
```

Allowed:

```text
22 SSH
80 HTTP
443 HTTPS
```

---

## Security Note

The current implementation intentionally uses permissive rules to simplify initial deployment.

Future phases will introduce:

- Least Privilege Networking
- Restricted SSH access
- Security Group references
- Bastion access architecture

---

# Compute Infrastructure

## freeipa-01

Purpose:

```text
Identity Management
```

Specifications:

```text
t3.small
20 GB encrypted gp3 volume
Private subnet
No public IP
```

Future services:

- FreeIPA
- LDAP
- Central Authentication
- RBAC

---

## security-01

Purpose:

```text
Security Monitoring Platform
```

Specifications:

```text
t3.small
40 GB encrypted gp3 volume
Public subnet
Public IP enabled
```

Future services:

- Wazuh
- Grafana
- Prometheus
- Suricata

---

## workload-01

Purpose:

```text
Application & Kubernetes Workloads
```

Specifications:

```text
t3.small
20 GB encrypted gp3 volume
Private subnet
No public IP
```

---

# EC2 Deployment Screenshot

```md
screenshots/phase-01-aws-foundation/ec2-instances.png
```

![EC2 Instances](../../../screenshots/phase-01-aws-foundation/ec2-instances.png)

The screenshot demonstrates:

- Successful deployment
- Naming convention consistency
- Running instance state
- Public/private architecture

---

# Terraform Project Structure

The Terraform configuration was refactored into multiple files to improve maintainability.

```text
backend.tf
compute.tf
locals.tf
main.tf
networking.tf
outputs.tf
provider.tf
remote-state.tf
security-groups.tf
terraform.tfvars.example
variables.tf
versions.tf
```

---

# Terraform Structure Screenshot

```md
screenshots/phase-01-aws-foundation/terraform-structure.png
```

![Terraform Structure](../../../screenshots/phase-01-aws-foundation/terraform-structure.png)

Benefits:

- Better readability
- Easier maintenance
- Cleaner separation of concerns
- Production-style Terraform structure

---

# Validation

## Terraform Validation

```bash
terraform validate
terraform plan
terraform apply
```

Result:

```text
Infrastructure deployed successfully
```

---

## SSH Validation

Test:

```bash
ssh ubuntu@<security-server-public-ip>
```

Result:

```text
Successful connection
```

Validated:

- Security Groups
- Routing
- Public subnet access
- SSH key pair configuration
- EC2 deployment

---

# Lessons Learned

During this phase the following concepts were implemented and understood:

- Terraform State Management
- Remote Backends
- State Locking
- Infrastructure as Code
- AWS Networking
- Public vs Private Subnets
- Internet Gateways
- Route Tables
- Security Groups
- EC2 Provisioning
- SSH Access Management
- Terraform Project Organization

---

# Future Improvements

Planned hardening activities:

- Restrict SSH access to a trusted IP
- Introduce Bastion Host architecture
- Security Group optimization
- Internal-only service exposure
- Additional monitoring controls

---

# Phase Outcome

Phase 01 successfully established a reusable and secure AWS foundation.

The environment now contains:

- Terraform Backend
- State Locking
- VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- Route Tables
- Security Groups
- Three EC2 Instances

This foundation will support all future phases of the Enterprise Security Lab.

---

# Next Phase

## Phase 02 – Identity & Access Management

Planned technologies:

- FreeIPA
- LDAP
- User Management
- Group Management
- RBAC
- Centralized Authentication

The goal is to implement enterprise identity management and establish a centralized authentication platform for all future services.
