#!/usr/bin/env bash
kubectl apply -f k8s/nginx/deployment.yaml
kubectl apply -f k8s/nginx/service.yaml
kubectl rollout status deployment -w 
minikube service nginx-service