# Habit Quest Terraform Deployment 🏗️☁️

This repository contains the **Terraform configuration** to deploy the **Habit Quest** Flask application on **AWS EC2** using Docker.

It demonstrates how a modern cloud-deployed application is provisioned, configured, and made publicly accessible, reflecting real-world DevOps practices.

---

## 🧱 Architecture Overview

```mermaid
flowchart TD
    Internet -->|HTTP/SSH| EC2[EC2 Instance]
    EC2 --> Docker[Docker Containers]
    Docker --> WebApp[Flask Application (Gunicorn)]
    Docker --> DB[PostgreSQL Database]
```

- The EC2 instance serves as the host for Docker containers.
- Docker containers include:
  - Flask Web Application (served via Gunicorn)
  - Nginx Reverse Proxy (exposes app on port 80)
  - PostgreSQL Database
- The application is publicly available at the EC2 instance's public IP.


## Terraform File Structure
| File                       | Purpose                                                      |
| -------------------------- | ------------------------------------------------------------ |
| `main.tf`                  | EC2 instance, security groups, and key pair creation         |
| `provider.tf`              | AWS provider configuration                                   |
| `variables.tf`             | Input variables for Terraform deployment                     |
| `outputs.tf`               | Outputs like public IP and SSH info                          |
| `user_data.sh`             | Script to bootstrap EC2 and run your containers              |
| `habit_quest_key` / `.pub` | SSH key for EC2 access (**ignored in GitHub**)               |
| `.terraform/`              | Terraform state and provider plugins (**ignored in GitHub**) |


## Deployment Flow

1. Configure AWS CLI (aws configure) outside the repo.
```
aws configure
```
2. Initialize Terraform:
```
terraform init
```
3.Validate configuration:
```
terraform validate
```
4. Plan the deployment:
```
Plan the deployment:
```
5. Apply the configuration:
```
terraform apply
```
6. SSH into EC2 to verify:
```
ssh -i habit_quest_key ec2-user@<EC2_PUBLIC_IP>
```
7. Access the Habit Quest app in a browser:
```
http://<EC2_PUBLIC_IP>:
```

## ⚙️ Post-Deployment Notes

- Database initialization runs automatically inside the container (Flask-Migrate) on startup.
- Persistent Docker volumes retain data across container restarts.
- The EC2 instance can be terminated when not in use to save costs — the Terraform setup can recreate it at any time.
- CI/CD pipelines can automatically redeploy updates to the EC2 instance once it is running.

## 🧠 Key Takeaways
#### This Terraform setup demonstrates:
- Automated EC2 provisioning and container orchestration
- Public exposure of a containerized web application via port 80
- Cloud-ready, repeatable deployment practices
- Integration with CI/CD pipelines for modern DevOps workflows
