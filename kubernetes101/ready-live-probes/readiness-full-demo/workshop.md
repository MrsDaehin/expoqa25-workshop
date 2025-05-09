

kubectl config current-context


check if you are in minikube 

## Setup DB

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami;
helm install postgres bitnami/postgresql --set auth.postgresPassword=postgres
```




Connect to the DB:

```bash
kubectl run postgres-postgresql-client --rm --tty -i --restart='Never' --namespace default --image docker.io/bitnami/postgresql:15.1.0-debian-11-r0 --env="PGPASSWORD=postgres" --command -- psql --host postgres-postgresql -U postgres -d postgres -p 5432
```

Create a Table:

```bash
CREATE TABLE accounts (
	account_id serial PRIMARY KEY,
	name VARCHAR ( 50 ) UNIQUE NOT NULL,
	owner_email VARCHAR ( 255 ) NOT NULL,
	created_on TIMESTAMP NOT NULL
);
```

Add dummy info:

```bash
INSERT INTO accounts(name,owner_email,created_on)
VALUES('demo', 'aaa@demo-test.com', CURRENT_DATE);
```

## SETUP IMAGES

mount images in docker to create application in K8s. 

```
eval $(minikube docker-env)
docker ps 
cd ready-live-probes/readiness-full-demo/apps/1_app_no_probes/
docker build . -t app-no-probes:0.0.1
```

```
eval $(minikube docker-env)
docker ps
cd 2_app_no_checks/
docker build . -t app-no-checks:0.0.1
```

```
eval $(minikube docker-env)
docker ps
cd 4_app_basic_check/
docker build . -t app-basic-check:0.0.1
```

```
eval $(minikube docker-env)
docker ps
cd 6_app_adv_check/
docker build . -t app-adv-check:0.0.1
```

### check the events

```
kubectl get pods -n <namespace>
kubectl describe pod <podname>
kubectl logs <podname>
```

### split terminal

```
watch -n 2 kubectl get pods
kubectl apply -f step1-probes-not-configured.yaml
```

### database is failing! remove a pod

```
sh db-not-ready.sh
```

### add a probe

```
kubectl  apply -f step2-probes-without-endpoint.yaml
kubectl describe pod <podname>
```
```
eval $(minikube docker-env)
docker ps 
cd ready-live-probes/readiness-full-demo/apps/2_app_no_checks/
docker build . -t app-no-checks:0.0.1
```


### new image, app no checks it doesn't check anything

```
kubectl apply -f step3-probes-without-checks.yaml   ### notice it takes a bit to start as there is a delay configured
```

### start the database

```
sh db-ready.sh
```

- readiness is not only part of the startup it is always running in background we expect the pod to be changed any time the database is going down the pod should be down

### new image,

```
eval $(minikube docker-env)
docker ps
cd 4_app_basic_check/
docker build . -t app-basic-check:0.0.1
```

### add a probe

```
kubectl apply -f step4-probes-with-basic-check.yaml
```

### the pod will fail but too slow we can improve that

```
kubectl apply -f step5-probes-with-adjusted-thresholds.yaml
```

### retrieve the logs from the pod and container to see why the pod is failing ( you can see the readiness probe fails )

```
kubectl logs <podname>
```

### last image with more checks to the database ( select, insert ... )

```
cd 6_app_adv_check/
docker build . -t app-adv-check:0.0.1
```

### add a probe

```
kubectl apply -f step6-probes-with-adv-check.yaml -n test
```
