# Lucee Task Event Gatways and Kubernetes 

Presentation demo code repository.

---
You can run the following:
1. Task Event Gateway Demo in Docker Compose
1. Nginx Service Demo in Kubernets
1. Task Event Gateway Demo in Kubernetes

## Running the Task Event Gateway Demo in Docker Compose
```
docker compose up --build --detach
```
This builds the lucee docker image and copies the config in from `config/lucee-web.xml.cfm`
You can access the demo at http://localhost:9999
![Demo View](assets/compose_demo.png)


## Running Minikube 
You can start and configure minikube by running the following:
```k8s/minikube_start```
This will run the following:
```
minikube start
minikube addons enable metrics-server
kubectl config use-context minikube
minikube dashboard &
```
The last command will open the dashboard in your browser and you can see the status of your cluster. 

## Running the Nginx Service Demo in Kubernetes
Now we have minikube running we can deploy the nginx service demo. 
```
k8s/nginx/deploy.sh
```
This will run the following commands:
```
kubectl apply -f k8s/nginx/deployment.yaml
kubectl apply -f k8s/nginx/service.yaml
kubectl rollout status deployment -w 
minikube service nginx-service
```
This will open the nginx service in your browser.

![Demo View](assets/nginx_demo.png)


## Running the Task Event Gateway Demo in Kubernetes





