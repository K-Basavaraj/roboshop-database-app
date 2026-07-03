# Redis Helm Deployment

## Overview

This directory contains the Helm chart used to deploy Redis into the Kubernetes cluster.

Unlike the frontend and backend applications, Redis does **not** require a custom Docker image. Instead, this deployment uses the official open-source Redis container image available publicly.

## Prerequisites

Before deploying, ensure that:

- Kubernetes cluster is running.
- `kubectl` is configured to access the cluster.
- Helm is installed.
- Namespace `roboshop` already exists.

Verify the namespace:

```bash
kubectl get ns
```

## Deployment

From the `redis` directory, run:

```bash
helm upgrade --install redis . -n roboshop
```

This command will:

- Install Redis if it does not exist.
- Upgrade the existing release if it is already deployed.

## Verify Deployment

Check whether the Redis pod is running:

```bash
kubectl get pods -n roboshop
```

Example output:

```text
NAME                     READY   STATUS    RESTARTS   AGE
redis-xxxxxxxxxx-xxxxx   1/1     Running   0          1m
```

## Helm Release Status

To verify the Helm release:

```bash
helm list -n roboshop
```

## Uninstall

To remove Redis from the cluster:

```bash
helm uninstall redis -n roboshop
```

## Notes

- Uses the official open-source Redis Docker image.
- No custom image build or push process is required.
- Deployment is managed entirely through Helm.