🚀 End-to-End-infra-using-Terraform

Enterprise-Grade AWS 3-Tier Architecture



📋 Project Overview

This project implements a highly available and secure 3-tier AWS infrastructure using Terraform Modules. The architecture is designed to host web applications with isolated networking layers, ensuring that the database remains private while the web tier handles traffic via an Application Load Balancer.


🏗️ Architecture Diagram

The following diagram represents the logical flow of traffic from the Internet to the private Database tier.
                            ┌─────────────────┐
                            │    INTERNET     │
                            └────────┬────────┘
                                     │
                                     ▼
                            ┌─────────────────┐
                            │  LOAD BALANCER  │
                            │ (Public Subnet) │
                            └────────┬────────┘
                                     │
            ┌────────────────────────┼────────────────────────┐
            │                        │                        │
            ▼                        ▼                        ▼
  ┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
  │  PUBLIC SUBNET  │      │ PRIVATE SUBNET  │      │ SECURE SUBNET   │
  │   AZ-a & AZ-b   │      │  AZ-a & AZ-b    │      │  AZ-a & AZ-b    │
  │                 │      │                 │      │                 │
  │                 │      │  ┌───────────┐  │      │  ┌───────────┐  │
  │  ┌───────────┐  │      │  │    EC2    │  │      │  │    RDS    │  │
  │  │    ALB    │  │      │  │ Web Tier  │  ├──────►  │   MySQL   │  │
  │  └───────────┘  │      │  └───────────┘  │      │  └───────────┘  │
  └─────────────────┘      └─────────────────┘      └─────────────────┘


📁 Project Structure & Modularization

To maintain scalability, the infrastructure is broken down into reusable modules.

[SCREENSHOT 1: VS Code Directory Tree]

[SCREENSHOT 2: Terraform Modules Folder Content]


🌐 Networking Tier (VPC)

A custom VPC was created in the ap-south-1 (Mumbai) region with segmented subnets for public and private resources.
VPC CIDR: 10.0.0.0/16
Subnets: 6 Subnets across 2 Availability Zones for fault tolerance.

[SCREENSHOT 3: VPC Resource Map]

[SCREENSHOT 4: Subnets & Availability Zones Dashboard]

[SCREENSHOT 5: Internet Gateway Attachment]

[SCREENSHOT 6: Route Tables Configuration]

🛡️ Security & Access Management

We implemented the Principle of Least Privilege using Security Groups to ensure only required ports are open.
ALB SG: Allows HTTP (80) from Anywhere.
EC2 SG: Allows traffic ONLY from the Load Balancer.
RDS SG: Allows traffic ONLY from the EC2 Security Group.

[SCREENSHOT 7: ALB Inbound Rules]

[SCREENSHOT 8: Web Tier Security Group]

[SCREENSHOT 9: Database Security Group]

[SCREENSHOT 10: Consolidated Security Group Overview]

🖥️ Compute & Load Balancing Tier

The Application Load Balancer (ALB) acts as the entry point, distributing traffic to EC2 instances based on health checks.

[SCREENSHOT 11: Running EC2 Instances Status]

[SCREENSHOT 12: Application Load Balancer (ALB) Active State]

[SCREENSHOT 13: Listener Rules & DNS Setup]

[SCREENSHOT 14: Target Group Registration & Health Check Settings]


🗄️ Database Tier (RDS)

A managed MySQL instance is deployed in the secure private subnets to prevent unauthorized external access.

[SCREENSHOT 15: RDS MySQL Instance Status]

[SCREENSHOT 16: DB Subnet Group Configuration]

⚠️ Troubleshooting: Debugging 502 Bad Gateway

During deployment, a 502 Bad Gateway error was encountered. This was used as a learning opportunity to debug the target health status.
Issue: Targets were showing as "Unhealthy".
Resolution: Verified Security Group port 80 and fixed the user-data script to ensure Nginx/Apache starts on boot.

[SCREENSHOT 17: Terraform Apply Execution Logs]

[SCREENSHOT 18: Browser 502 Bad Gateway Error Page]

[SCREENSHOT 19: Unhealthy Health Checks in AWS Console]

[SCREENSHOT 20: Verified Healthy Status After Fix]


📝 Best Practices Implemented

✅ Modular Infrastructure: Separation of concerns using modules.
✅ High Availability: Resources deployed across Multiple Availability Zones.
✅ Zero-Trust Security: Database tier completely isolated from the internet.
✅ State Management: Remote S3 Backend for state consistency.
✅ Automated Health Checks: Real-time monitoring of instances via ALB.


🚀 Installation & Deployment

1.Clone the Repository
https://github.com/dhirajrajput2/End-to-End-infra-using-Terraform.git

2.Initialize & Apply
terraform init
terraform plan
terraform apply -auto-approve
