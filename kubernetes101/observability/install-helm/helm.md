helm search hub Prometheus

![](assets/20250504_174733_image.png)

```console
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

![](assets/20250504_174920_image.png)

We have downloaded the last version of prometheus.

```console
helm install prometheus prometheus-community/prometheus
```

after installing prometheus we can run kubectl command


![](assets/20250504_175406_image.png)
