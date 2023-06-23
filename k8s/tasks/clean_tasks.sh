#! /bin/bash
kubectl delete deployments tasks-server
kubectl delete service tasks-server
kubectl delete hpa tasks-hpa