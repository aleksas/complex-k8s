[![Build Status](https://travis-ci.org/aleksas/nginx-redis-react-pg.svg?branch=master)](https://travis-ci.org/aleksas/nginx-redis-react-pg)

# nginx-redis-react-pg
## Shemas 
### Development 
![image](https://user-images.githubusercontent.com/594470/69322256-34702000-0c4d-11ea-9f71-d5db952ab0f6.png)
### Production 
![image](https://user-images.githubusercontent.com/594470/69324643-83b84f80-0c51-11ea-9501-a7da073d42f7.png)

## External preparations
### GCloud
- AUTH
  - in gcloud console IAM add travis-deployer user and save key...json file
  - encode this key file using travis
- run following command in gcloud cluster console
    ```bash
    gcloud config set project multi-k8s-260107
    gcloud config set compute/zone europe-north1-a
    gcloud container clusters get-credentials multi-cluster
    kubectl create secret generic pgpassword --from-literal PGPASSWORD=YOUR_PG_PASSWORD
    ```
- run ```
helm repo add stable https://kubernetes-charts.storage.googleapis.com/helm
repo update
helm install stable/nginx-ingress --generate-name --set rbac.create=true
```
- [install helm/tiller](https://helm.sh/docs/intro/install/#from-script)) on gcloud k8s using same console
  - run following commands also
    - `kubectl create serviceaccount --namespace kube-system tiller`
    - `kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller`
    
### Docker Hub
- Set Travis project settings environment vars to have 
  - DOCKER_ID
  - DOCKER_PASSWORD
  
## References 
- [Udemi - Docker and Kubernetes: The Complete Guide](https://github.com/StephenGrider/DockerCasts)

