# Roboshop Database Deployment

## Overview

This repository contains the deployment artifacts required to deploy the database components of the Roboshop application on Amazon EKS.

The deployment includes:

- MongoDB
- Redis
- RabbitMQ

MongoDB uses a custom Docker image that is built locally and pushed to Amazon ECR before deployment.

Redis and RabbitMQ use official open-source container images and are deployed directly using Helm.

---

## Deployment Environment

The **Bastion Host** is used as:

- Docker Build Server
- Amazon EKS Client
- Helm Client

All the commands in this guide should be executed from the **Bastion Host**.

---

## Prerequisites

Ensure the following tools are installed and configured on the Bastion Host:

- AWS CLI
- Docker
- kubectl
- Helm

Configure AWS credentials:

```bash
aws configure
```

Update the kubeconfig for the EKS cluster:

```bash
aws eks update-kubeconfig --region us-east-1 --name roboshop-dev
```

Verify cluster connectivity:

```bash
kubectl get nodes
```

---

## Clone the Repository

Clone this repository onto the **Bastion Host**.

```bash
git clone <repository-url>
```

Navigate to the repository.

```bash
cd roboshop-database-app
```

---

## Deploy the Database Components

Make the deployment script executable:

```bash
chmod +x deploy.sh
```

Run the deployment script:

```bash
./deploy.sh
```

The script automatically performs the following operations:

1. Updates the kubeconfig for the EKS cluster.
2. Creates the `roboshop` namespace if it does not already exist.
3. Logs in to Amazon ECR.
4. Builds the MongoDB Docker image.
5. Pushes the MongoDB image to Amazon ECR.
6. Deploys MongoDB using Helm.
7. Deploys Redis using Helm.
8. Deploys RabbitMQ using Helm.
9. Displays the deployment status.

---

## Verify Deployment

Check the deployed pods:

```bash
kubectl get pods -n roboshop
```

Verify the Helm releases:

```bash
helm list -n roboshop
```

---

## Repository Structure

```
roboshop-database-app/
│
├── deploy.sh
├── mongodb/
├── redis/
├── rabbitmq/
└── README.md
```

---

## Deployment Summary

| Component | Deployment Method |
|-----------|-------------------|
| MongoDB | Build Docker image → Push to Amazon ECR → Deploy using Helm |
| Redis | Deploy official open-source image using Helm |
| RabbitMQ | Deploy official open-source image using Helm |

---

## Notes

- Execute all commands from the **Bastion Host**.
- The Bastion Host acts as both the Docker build server and the Amazon EKS client.
- MongoDB image is built and pushed to Amazon ECR during deployment.
- Redis and RabbitMQ use official open-source images; no image build is required.
- The deployment script can be executed multiple times safely.