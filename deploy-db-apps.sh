#!/bin/bash

set -e

AWS_REGION="us-east-1"
ACCOUNT_ID="688567303455"
ECR_REPO="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/roboshop/dev/mongodb"
NAMESPACE="roboshop"

echo "Updating kubeconfig..."
aws eks update-kubeconfig --region ${AWS_REGION} --name roboshop-dev

echo "Creating namespace if it doesn't exist..."
kubectl create namespace ${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

echo "Logging into Amazon ECR..."
aws ecr get-login-password --region ${AWS_REGION} | \
docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

echo "Building MongoDB image..."
cd mongodb
docker build -t ${ECR_REPO}:v1.0.0 .

echo "Pushing MongoDB image..."
docker push ${ECR_REPO}:v1.0.2

echo "Deploying MongoDB..."
cd helm
helm upgrade --install mongodb . -n ${NAMESPACE}
cd ../

echo "Deploying Redis..."
cd redis/helm
helm upgrade --install redis . -n ${NAMESPACE}
cd ../..

echo "Deploying RabbitMQ..."
cd rabbitmq/helm
helm upgrade --install rabbitmq . -n ${NAMESPACE}
cd ../..

echo "Deployment completed successfully."

kubectl get pods -n ${NAMESPACE}
