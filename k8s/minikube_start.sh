#!/bin/bash
minikube start
minikube addons enable metrics-server
kubectl config use-context minikube
minikube dashboard &