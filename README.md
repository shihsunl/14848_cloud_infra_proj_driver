# 14848_cloud_infra_proj_driver

## How to build docker image
- Run `docker build --no-cache --progress=plain -t YOUR_DOCKER_ID/14848_proj_driver:ssh . ` and push the image to DockerHub.

## Deploy docker image to Google Cloud Platform Kubernetes Cluster
- Open Cloud Shell on GCP and clone the repository:
```
git clone https://github.com/shihsunl/14848_cloud_infra_proj_driver.git
```
- Modify docker image in `resource-manifests/main_driver_ssh_development.yaml`.
- Execute 2 yaml file in resource-manifests folder.
```
cd 14848_cloud_infra_proj_driver/resource-manifests/
kubectl apply -f main_driver_ssh_development.yaml
kubectl create -f service_main_driver_ssh-lb.yaml
```
- Then, you can check Workloads and Service & Ingress
![workloads](screenshot/workloads.png)
![service](screenshot/service.png)
![service_detail](screenshot/service_detail.png)

- Now, Front-End Service is ready! You can open your browser and access the IP with port 80. For my example, according to the Service & Ingress page, I can use 34.135.47.138:80 to access Service website and select the service that you want.
- Before you select the service, make sure you deploy the service to Google Cloud Platform Kubernetes Cluster.

- Service Website
![website](screenshot/website.png)
- Hadoop Service
![hadoop](screenshot/hadoop.png)
- Spark Service
![spark](screenshot/spark.png)
- SonarQube and SonarScanner Service
![sonarqube](screenshot/sonarqube.png)
- Jupyter Service
![jupyter](screenshot/jupyter.png)
- I've used Reverse Proxy to make different url paths redirect to different services. For instance, when you use `34.135.47.138/spark`, it will redirect to `http://spark-service` which is the spark service with port 8080. You can check `https://github.com/shihsunl/14848_cloud_infra_proj_spark/blob/master/resource-manifests/service-spark.yaml` for more detail.
![reverse_proxy](screenshot/reverse_proxy.png)
