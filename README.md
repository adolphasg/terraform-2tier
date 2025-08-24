# Terraform 2‑Tier AWS Architecture (VPC + EC2 + RDS)

This project provisions a **highly‑available 2‑tier infrastructure on AWS** using **Terraform** with **Terraform Cloud (VCS workflow)** and **GitHub** as the source of truth.  

It deploys:

- A custom **VPC** with public and private subnets.  
- EC2 instances in the public subnets running **NGINX**.  
- An **RDS MySQL database** in private subnets.  
- Outputs for web server URLs and the RDS endpoint.  

---

### Architecture (Mermaid)

graph TD
  Internet --> ALB[ALB / Public Subnet]
  ALB --> Web1[EC2 (NGINX) - Public subnet A]
  ALB --> Web2[EC2 (NGINX) - Public subnet B]
  subgraph VPC["VPC (10.0.0.0/16)"]
    direction TB
    subgraph Public["Public subnets"]
      Web1
      Web2
    end
    subgraph Private["Private subnets"]
      RDS[RDS MySQL - Private subnets]
    end
  end
  Web1 -->|3306| RDS
  Web2 -->|3306| RDS

---

### Repository Structure (Mermaid)

flowchart TB
  repo["terraform-2tier/"]
  repo --> versions["versions.tf"]
  repo --> variables["variables.tf"]
  repo --> main["main.tf"]
  repo --> outputs["outputs.tf"]
  repo --> modules["modules/"]
  modules --> vpc["vpc/"]
  vpc --> vpc_main["main.tf"]
  vpc --> vpc_vars["variables.tf"]
  vpc --> vpc_out["outputs.tf"]
  modules --> web["web/"]
  web --> web_main["main.tf"]
  web --> web_vars["variables.tf"]
  web --> web_out["outputs.tf"]
  modules --> rds["rds/"]
  rds --> rds_main["main.tf"]
  rds --> rds_vars["variables.tf"]
  rds --> rds_out["outputs.tf"]

---

## ⚙️ Prerequisites

- [Git](https://git-scm.com/) installed.  
- [Terraform Cloud](https://app.terraform.io) account.  
- [AWS Account](https://aws.amazon.com/).  
- IAM User/Role with permissions for VPC, EC2, Security Groups, and RDS.  
- (Optional) [SSH key pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) created in AWS for EC2 access.

---

## Getting Started

### **1. Clone this repo**

```bash
git clone https://github.com/adolphasg/terraform-2tier.git
cd terraform-2tier

2. Connect GitHub Repo to Terraform Cloud
Log into Terraform Cloud.
Create a new Workspace → choose VCS Workflow.
Link GitHub and select this repo (terraform-2tier).
Choose your branch (main).
3. Configure Variables in Terraform Cloud

In your workspace → Variables tab:

Environment Variables

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY

Terraform Variables

db_password (mark as sensitive)
Override defaults (if needed): region, VPC CIDR, instance type, etc.
4. Push Code to Trigger a Run

Make code changes, then push:

git add .
git commit -m "Deploy 2-tier AWS architecture"
git push origin main


Terraform Cloud will automatically:

Fetch latest commit.
Run terraform init + terraform plan.
Wait for you to click Confirm & Apply.
Execute terraform apply in AWS.
5. View Outputs

After a successful apply, go to your Terraform Cloud workspace → Outputs tab. You’ll see:

web_urls → copy into browser to check NGINX
rds_endpoint → use in MySQL client connection
vpc_id → VPC reference in AWS
6. Test RDS Connectivity

SSH into one of your web servers (ec2-user@<public-ip>).

Install MySQL client:

sudo yum install mysql -y


Connect to RDS:

mysql -h <RDS_ENDPOINT> -u <DB_USERNAME> -p <DB_NAME>


Enter your password → you should see the mysql> prompt 

7. Destroy Infrastructure

To avoid AWS costs:

In Terraform Cloud → Workspace → Settings → Destruction and Deletion.
Click Queue destroy plan (recommended).
Confirm — Terraform will delete all resources it created.
💡 Notes
Every git push to the connected branch triggers a new Terraform run.
Terraform Cloud is your single source of truth — state is managed remotely.
Use Queue Destroy Plan to safely remove resources when done.
📚 References
Terraform Cloud: Getting Started
AWS Provider Docs
GitHub Docs: Adding a Repository

---
# terraform-2tier