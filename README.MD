# Assignment 2

**Author:** Yu-Ming (Jonathan) Wang

---

## 🗁 Repository Structure

```
Cloud-Computing-Assignment-2/
│
├── Dockerfile                         # Flask app image definition
├── docker-compose.yml                 # Optional local test
├── flask-deployment.yaml              # Minikube: Flask Deployment & Service
├── mongo-deployment.yaml              # Minikube: MongoDB Deployment & Service
├── flask-deployment_eks.yaml          # EKS: Flask Deployment & Service
├── mongo-deployment_eks.yaml          # EKS: MongoDB Deployment & Service
├── screenshots/                       # All screenshots go here
└── README.md
```

---

## 🧱 1. Docker Image for Flask Application

### Dockerfile

define flask-todo image

---

## 🧩 2. Local Test via Docker Compose and push to Docker Hub

### docker-compose.yml

```bash
docker-compose up
```

```bash
docker start flask
```

```bash
docker logs -f flask-todo
```
Open the service in a browser

✅ **Screenshot:** ![Local App Running](screenshot/local_app_running.png)
✅ **Screenshot:** ![Docker push](screenshot/dockerhub.png)

---

## ☸️ 3. Deploy on Minikube

### Start Cluster

```bash
minikube start
```

### Deploy MongoDB + Flask

```bash
kubectl apply -f mongo-deployment.yaml
kubectl apply -f flask-deployment.yaml
```

### Verify

```bash
kubectl get pods
kubectl get svc
```

### Access the App

```bash
minikube service flask-to-service
```

### Stop MiniKube service

```bash
minikube stop
```

✅ **Screenshots:**

* ![Minikube Pods](screenshot/minikube_deploy.png)
* ![App Running](screenshot/minikube_app_running.png)

---

## ☁️ 4. Deploy on AWS EKS

### Create Cluster (via AWS Console)

1. Navigate to EKS → **Create Cluster**
2. Choose Kubernetes version 1.33
3. Add Node Group (t3.medium × 2)
4. Wait until status = **Active**

✅ **Screenshot:** ![EKS Console](screenshot/eks_cluster_console.png)

### Create new config

```bash
aws eks --region us-east-1 update-kubeconfig --name <cluster_name>
kubectl get nodes
```
✅ **Screenshot:** ![EKS Console](screenshot/eks_get_node.png)

### Switch kubectl to EKS cluster config

```bash
kubectl config get-contexts 
kubectl config use-context arn:aws:eks:us-east-1:767828756359:cluster/nyu-flask-eks
```

### Deploy App

```bash
kubectl apply -f mongo-deployment_eks.yaml
kubectl apply -f flask-deployment_eks.yaml
```

### Check Status

```bash
kubectl get pods
kubectl get svc
```

### Open service
```bash
http://aac29ca36dc684ab3b215927d1e76622-1360838796.us-east-1.elb.amazonaws.com:5000
```

✅ **Screenshots:**

* ![EKS Service](screenshot/eks_pod_service.png)
* ![EKS App Running](screenshot/eks_app_running.png)

---

## 🔄 5. Deployments and ReplicaSets

```bash
# Check deployment
kubectl get deployment flask-todo-deployment
```

```bash
# Check ReplicaSets
kubectl get rs
```

✅ **Screenshot:** ![rs](screenshot/eks_rs.png)

### Pod Recovery Demo

```bash
kubectl delete pod <flask_pod_name>
kubectl get pods
```

✅ **Screenshot:** ![Pod Recovery](screenshot/pod_recovery.png)

---

## 🔄 6. Rolling Update

```bash
# Update image version
kubectl set image deployment/flask-deployment flask=yw8988/flask-todo:v2

# Check rollout progress
kubectl rollout status deployment/flask-deployment
```

✅ **Screenshot:** ![Rolling Update](screenshot/rolling_update.png)

### Pod Recovery Demo

```bash
kubectl delete pod <flask_pod_name>
kubectl get pods
```

✅ **Screenshot:** ![Pod Recovery](screenshot/pod_recovery.png)

---

## ❤️‍🔥 6. Health Probes and Monitoring

```yaml
livenessProbe:
  httpGet:
    path: /
    port: 5000
  initialDelaySeconds: 10
  periodSeconds: 15

readinessProbe:
  httpGet:
    path: /
    port: 5000
  initialDelaySeconds: 5
  periodSeconds: 10
```

Check:

```bash
kubectl describe pod <flask_pod_name>
```

✅ **Screenshot:** ![Health Probe](screenshots/health_probe_status.png)

---

## 📈 7. ReplicaSet Scaling

```bash
kubectl scale deployment flask-deployment --replicas=3
kubectl get rs
```

✅ **Screenshot:** ![ReplicaSet Scaled](screenshots/replicaset_scaled.png)

---

## ⚡ (Extra Credit 30 pts) Prometheus + Slack Alerting

Optional bonus section for alert integration tests.
Include: `prometheus-deployment.yaml`, `alertmanager-config.yaml`, and Slack alert screenshot.
