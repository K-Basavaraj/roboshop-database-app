# RabbitMQ Helm Deployment

## Overview

This directory contains the Helm chart used to deploy RabbitMQ into the Kubernetes cluster.

RabbitMQ uses the official open-source Docker image. There is no requirement to build or push a custom container image before deployment.

## Prerequisites

Before deploying, ensure that:

- Kubernetes cluster is running.
- `kubectl` is configured.
- Helm is installed.
- Namespace `roboshop` already exists.

Verify the namespace:

```bash
kubectl get ns
```

## Deployment

From the `rabbitmq` directory, execute:

```bash
helm upgrade --install rabbitmq . -n roboshop
```

This command will:

- Install RabbitMQ if it does not already exist.
- Upgrade the deployment if the release is already installed.

## Verify Deployment

Check the running pods:

```bash
kubectl get pods -n roboshop
```

Example output:

```text
NAME                          READY   STATUS    RESTARTS   AGE
rabbitmq-xxxxxxxxxx-xxxxx     1/1     Running   0          1m
```

## Helm Release Status

To verify the Helm release:

```bash
helm list -n roboshop
```

## Uninstall

To remove RabbitMQ from the cluster:

```bash
helm uninstall rabbitmq -n roboshop
```

## Notes

- Uses the official open-source RabbitMQ Docker image.
- No Docker image build or push is required.
- Deployment is managed using Helm.