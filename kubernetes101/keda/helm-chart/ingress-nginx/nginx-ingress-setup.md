## Nginx Ingress 설정

### Nginx ingress 설치

```bash
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace -f custom-default-backend.helm.values.yaml 
```

```yaml
tee custom-default-backend.helm.values.yaml <<EOF
controller:
  config: 
    custom-http-errors: "404,503"
  replicaCount: 2
defaultBackend:
  enabled: true
  image:
    registry: k8s.gcr.io
    image: ingress-nginx/nginx-errors
    tag: "0.48.1"
  extraVolumes:
  - name: custom-error-pages
    configMap:
      name: custom-error-pages
      items:
      - key: "404"
        path: "404.html"
      - key: "503"
        path: "503.html"
  extraVolumeMounts:
  - name: custom-error-pages
    mountPath: /www
EOF
```

```bash
kubens ingress-nginx
```

### Nginx ingress custom 설정(http-error)

https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/

```bash
kubectl get cm/ingress-nginx-controller
...
data:
  allow-snippet-annotations: "true"
  custom-http-errors: 404,503
...
```

```bash
k apply -f custom-default-backend-error_pages.configMap.yaml 
configmap/custom-error-pages created
```
[ConfigMap](https://github.com/kubernetes/ingress-nginx/blob/main/docs/examples/customization/custom-errors/custom-default-backend-error_pages.configMap.yaml)

### 데모 앱 배포 

```bash
kubectl create deployment demo --image=httpd --port=80
kubectl expose deployment demo

kubectl create ingress demo --class=nginx \
  --rule="www.test.com/*=demo:80"
```

```bash
$ kubectl get ingress/demo
NAME   CLASS   HOSTS          ADDRESS         PORTS   AGE
demo   nginx   www.test.com   34.64.248.161   80      51s
```

### host file update and verify

```bash
curl www.test.com
<html><body><h1>It works!</h1></body></html>

curl www.test.com/test
<!DOCTYPE html>
<html>
  <head><title>404 PAGE NOT FOUND</title></head>
  <body>404 PAGE NOT FOUND</body>
</html>
```

```bash
kubectl delete deploy demo
deployment.apps "demo" deleted

curl www.test.com
<!DOCTYPE html>
<html>
  <head><title>CUSTOM SERVICE UNAVAILABLE</title></head>
  <body>CUSTOM SERVICE UNAVAILABLE</body>
</html
```

## reference
https://kubernetes.github.io/ingress-nginx/examples/customization/custom-errors/