# Terraform Database Reliability Assessment

## Overview

This repository contains my solution for the **DevOps Assessment: Terraform + Database Reliability**.

The objective of this project is to demonstrate infrastructure design using Terraform, database administration skills, automation using shell scripts, and CI validation using GitHub Actions.

> **Note:** This project is designed for learning and interview evaluation purposes. AWS resources are **not deployed**. The Terraform code is validated using `terraform fmt`, `terraform validate`, and `terraform plan` to simulate a production-ready infrastructure.

---

# Technology Stack

* Terraform
* AWS
* Docker Compose
* MySQL
* GitHub Actions
* Shell Scripting
* Git

---

# Project Architecture

```text
                 Internet
                     │
                     ▼
        Application Load Balancer (ALB)
                     │
                     ▼
            ECS Fargate Service
                     │
                     ▼
          Amazon RDS (MySQL - Private)
```

Infrastructure components include:

* Virtual Private Cloud (VPC)
* Public and Private Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups
* Application Load Balancer
* ECS Cluster
* ECS Service
* ECS Task Definition
* Amazon RDS MySQL

The RDS database is deployed in private subnets and is accessible only from the ECS service through Security Groups.

---

# Repository Structure

```text
terraform-db-reliability/
│
├── infra/
│
├── modules/
│   ├── network/
│   ├── security/
│   ├── alb/
│   ├── ecs/
│   └── rds/
│
├── envs/
│   ├── dev/
│   └── prod/
│
├── database/
│   ├── migrations/
│   ├── seeds/
│   └── indexes/
│
├── scripts/
│   ├── backup.sh
│   ├── restore.sh
│   └── optimize.sh
│
├── .github/
│   └── workflows/
│       └── terraform.yml
│
├── docker-compose.yml
│
└── README.md
```

---

# Terraform Modules

## Network

Creates:

* VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* NAT Gateway
* Route Tables

---

## Security

Creates Security Groups for:

* Application Load Balancer
* ECS/Fargate
* RDS MySQL

---

## Application Load Balancer

Creates:

* ALB
* Target Group
* Listener
* Listener Rules

---

## ECS

Creates:

* ECS Cluster
* Task Definition
* ECS Service
* CloudWatch Log Group
* IAM Roles

A simple Nginx container is used as the sample application.

---

## RDS

Creates:

* MySQL Database
* DB Subnet Group
* Parameter Group

Database access is restricted to the ECS Security Group.

---

# Environment Configuration

Two environments are included.

## Development

* Smaller instance sizes
* Backup retention: 1 day
* Deletion protection: Disabled

## Production

* Larger instance sizes
* Backup retention: 7 days
* Deletion protection: Enabled

---

# Database

The local database runs using Docker Compose.

## Tables

### hotel_bookings

Stores hotel reservation information.

### booking_events

Stores booking-related events.

---

# Migration

Start the database:

```bash
docker compose up -d
```

Run the migration SQL file:

```bash
mysql -u root -p < database/migrations/001_create_tables.sql
```

---

# Seed Data

Seed the database:

```bash
mysql -u root -p < database/seeds/seed_data.sql
```

The seed data includes:

* 100+ hotel bookings
* Multiple organizations
* Multiple cities
* Multiple booking statuses
* Booking events

---

# Query Optimization

The following query is optimized:

```sql
SELECT
    org_id,
    status,
    COUNT(*),
    SUM(amount)
FROM hotel_bookings
WHERE city='delhi'
AND created_at >= NOW() - INTERVAL 30 DAY
GROUP BY org_id,status;
```

## Optimization

Indexes are created on frequently filtered and grouped columns.

Example:

```sql
CREATE INDEX idx_city_created_status_org
ON hotel_bookings(city, created_at, org_id, status);
```

This composite index improves filtering on `city` and `created_at` while also supporting grouping by `org_id` and `status`, reducing the amount of data that MySQL needs to scan.

---

# Backup

Run:

```bash
./scripts/backup.sh
```

The script creates a timestamped SQL backup.

Example output:

```text
backup_20260708_120000.sql
```

---

# Restore

Run:

```bash
./scripts/restore.sh
```

The script restores the latest backup into a fresh local database.

---

# Verification

Terraform:

```bash
terraform fmt
terraform init
terraform validate
terraform plan -refresh=false
```

Docker:

```bash
docker compose up -d
```

Database:

* Verify that both tables exist.
* Confirm that at least 100 booking records have been inserted.
* Execute the optimized query and compare the execution plan before and after creating the index.

---

# GitHub Actions

The workflow automatically performs:

* Terraform Format Check
* Terraform Initialization
* Terraform Validation
* Terraform Plan

The generated Terraform plan is available in the workflow logs or as a workflow artifact.

---

# Future Improvements

* ECS Auto Scaling
* HTTPS using ACM
* CloudWatch Alarms
* Secrets Manager integration
* Remote Terraform State using Amazon S3 and DynamoDB
* Multi-AZ RDS deployment
* Blue/Green deployment strategy
* Monitoring with Amazon CloudWatch

---

# Learning Outcomes

This project helped me strengthen my understanding of:

* Infrastructure as Code (Terraform)
* AWS networking concepts
* ECS Fargate architecture
* Amazon RDS configuration
* Database backup and restore
* SQL indexing and query optimization
* Docker Compose
* GitHub Actions
* CI/CD best practices

---

# Author

**Mohammed Rizwan Khan**

DevOps Engineer

GitHub: https://github.com/mdrizwankhan7307-sketch
