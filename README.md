# AWS EKS GitOps Platform

A containerized FastAPI application deployed to Amazon EKS using Terraform, Kustomize, and Argo CD.

## Deployment flow

Terraform provisions the AWS network and EKS cluster. Docker builds and pushes the API image to ECR. Argo CD watches this repository and syncs the Kubernetes manifests from Git.

Image build and push are currently manual; Argo CD automates deployment.

## Stack

AWS EKS, ECR, Terraform, Docker, Kubernetes, Kustomize, Argo CD, Python, FastAPI

## Repository layout

```text
app/                  FastAPI application and Dockerfile
infra/terraform/      AWS infrastructure
gitops/apps/          Kubernetes base and dev overlay
gitops/argocd/        Argo CD Application
```

## Run locally

```powershell
Set-Location .\app
python -m pip install -r requirements.txt
python -m uvicorn main:app --reload
```

Visit `http://localhost:8000/healthz` or `http://localhost:8000/docs`.

## Deploy

Set your public IP as `admin_cidr` in the ignored file `infra/terraform/terraform.tfvars`, then run:

```powershell
Set-Location .\infra\terraform
terraform init
terraform apply
```

After configuring `kubectl` and installing Argo CD, apply the Argo CD Application:

```powershell
kubectl apply -f .\gitops\argocd\task-api-dev.yaml
```

The application is available inside the cluster at Service `task-api`, port `80`.

## Cleanup

After the project is published, destroy the Terraform infrastructure:

```powershell
Set-Location .\infra\terraform
terraform destroy
```

Then remove the ECR repository:

```powershell
aws ecr delete-repository --repository-name task-api --region ap-southeast-2 --force
```

Keep Terraform state until `terraform destroy` succeeds. AWS resources may incur charges while running.