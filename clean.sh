#!/bin/bash
kubectl delete -n default deployment redis-commander-local
kubectl delete -n default deployment redis-ui
kubectl delete -n default deployment redis-server-local
kubectl delete -n default deployment tasks-server
kubectl delete -n default deployment nginx-deployment

kubectl delete -n default service redis-commander-local
kubectl delete -n default service redis-ui-service
kubectl delete -n default service redis-server-local
kubectl delete -n default service tasks-server
kubectl delete -n default service nginx-service