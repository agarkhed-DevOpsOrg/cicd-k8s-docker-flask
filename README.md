# Deploying a Flask/Python Project on K8s and monitoring using Grafana and Prometheus

## Technology stack used:

| Name | Usage | Description |
| --- | --- | --- |
|Jenkins | Deployment|to poll code from github,deploy and execute run-scripts.sh |  | | |
|Docker| Containerization| to containerize flask-app, grafana and prometheus|
|K8s| container orchestration|runs pods with flask-app |
|Grafana| visualization and analytics| for analysis of metrics of webapp|
|Prometheus| event monitoring and alerting| for analysis of metrics of webapp|
|AWS EC2| Ubuntu Linux 18.04| for Docker and Jenkins server|

## Jenkins: Post-build Actions>Send build artifacts over ssh>Exec command
```
sudo chmod +x run-scripts.sh
${DOCKERPWD} | docker login --username ashwinpagarkhed --password-stdin
./run-scripts.sh sh
``` 
![Jenkins Builds](https://github.com/agarkhed-DevOpsOrg/cicd-pipeline-k8s-docker-jenkins-flask/blob/master/images/buildGraph.png?raw=true)

## To Delete Resources on Docker Server
```
sudo docker kill $(docker ps -q)
sudo docker container rm $(sudo docker ps -a)
sudo docker rmi $(docker images -a -q)
```

## To Build Image
```
sudo docker build -t ashwinpagarkhed/image:latest .
```

## To Push Image to dockerhub 
```
sudo docker push ashwinpagarkhed/image
```

## To Run grafana container
```
docker run -it -d -p 3000:3000 --network=docker-network -t network-node-1 grafana/grafana
```

## To Run prometheus container
```
docker run -it -d -p 9090:9090 --network=docker-network -t network-node-2 prom/prometheus
```
###### Note:- After both these are up, login to grafana as admin and add datasource as prometheus
![Grafana metrics](https://github.com/agarkhed-DevOpsOrg/cicd-pipeline-k8s-docker-jenkins-flask/blob/master/images/Grafana.png?raw=true)

## To Run flask container
```
docker run -d -it -p 5002:5000 --network=docker-network -t network-node-3 ashwinpagarkhed/image:latest
```
###### Note:- In my code, I have run the flask normally. Make these changes in your code if you want to run flask container in docker network


## Kubernetes command to run flask pods on minikube 
```
kubectl apply -f resources.yaml
```
![Running Pods Status](https://github.com/agarkhed-DevOpsOrg/cicd-pipeline-k8s-docker-jenkins-flask/blob/master/images/kubectlStatus.png?raw=true)
