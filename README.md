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
- Spark Service: `https://github.com/shihsunl/14848_cloud_infra_proj_spark`
- Jupyter Service: `https://github.com/shihsunl/14848_cloud_infra_proj_jupyter`
- Hadoop Service: `https://github.com/shihsunl/14848_cloud_infra_proj_hadoop`
- SonarQube and SonarScanner Service: `https://github.com/shihsunl/14848_cloud_infra_proj_sonarqube_sonarscanner`

-------

## Services

- Service Website
![website-1](screenshot/website1.png)
![website-2](screenshot/website2.png)

- Web-based Terminal
![terminals](screenshot/terminals.png)
![terminal-example](screenshot/terminal-example.png)

- I've used Reverse Proxy to make different url paths redirect to different services. For instance, when you use `34.135.47.138/spark`, it will redirect to `http://spark-service` which is the spark service with port 8080. You can check `https://github.com/shihsunl/14848_cloud_infra_proj_spark/blob/master/resource-manifests/service-spark.yaml` for more detail.
![reverse_proxy](screenshot/reverse_proxy1.png)
![reverse_proxy](screenshot/reverse_proxy2.png)

- Hadoop Service
![hadoop](screenshot/hadoop.png)
- Spark Service
![spark](screenshot/spark.png)
- Jupyter Service
![jupyter](screenshot/jupyter.png)
- SonarQube Service
![sonarqube](screenshot/sonarqube.png)
- SonarScanner Demo Website
    - I've created a RESTful API Server to help users use SonarScanner. Users can also access the web-based terminal and use commandline.
    - How to use: 
        - First you need to create a project in SonarQube and get the token.
        - Then, choose a repository that you want to scan.
        - Input Git repo url, Repo project name, SonarQube Project Key, and SonarQube Project token
        - Or you can use API `http://{FrontEnd_Website_Public_IP}/{BASE_URL}/scanrun` to trigger SonarScanner.
        - Example: 
        ```
        curl -X POST -F 'git_url=https://github.com/xxx/xxxxx.git' -F 'projectkey=YOUR_PROJECT_KEY' -F 'sources=PROJECT_NAME' -F 'token=xxxxxxxxx'  'http://{FrontEnd_Website_Public_IP}/{BASE_URL}/scanrun'

        curl -X POST -F 'git_url=https://github.com/shihsunl/14848_Cloud_Infra_HW3.git' -F 'projectkey=test76' -F 'token=3e7c17d0634217c9946d3cb994d299bd1a22fb59' -F 'sources=14848_Cloud_Infra_HW3' 'http://34.135.47.138/sonarscanner/scanrun'
        ```
![sonarscanner](screenshot/sonarscanner.png)
