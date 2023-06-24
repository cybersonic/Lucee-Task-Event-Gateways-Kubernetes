#! /bin/bash

tag=$(date +%s%N | sha256sum | head -c 8)
label="distrokid/teg-demo:${tag}"
echo "Building ${label}"
docker build -t ${label} .
docker tag ${label} distrokid/teg-demo:latest

echo "Starting to load ${label} into minikube"
minikube image load ${label}

echo "Starting to load distrokid/teg-demo:latest into minikube"
minikube image tag ${label} distrokid/teg-demo:latest

echo "Making sure we have the metrics-server addon enabled"
# Enable metrics server for scaling
minikube addons enable metrics-server
# Make sure we are using the right minkube context
kubectl config use-context minikube
echo "Deploy redis to our minikube cluster"
# Redis stuff
kubectl apply -f k8s/redis/deployment.yaml
kubectl apply -f k8s/redis_ui/deployment.yaml

echo "Deploying the tasks app to our minikube cluster"
# deploy the deployment of the app
kubectl apply -f k8s/tasks/deployment.yaml
kubectl apply -f k8s/tasks/hpa.yaml

echo "Set the image manually so that we can see the rollout status"
# Set the image
kubectl set image deployment/tasks-server tasks-server=${label}
# Check the status
kubectl rollout status deployment/tasks-server
# Check the status of HPA
kubectl get hpa

# open the page to our app
minikube service tasks-server