# Ingress Nginx Helm Chart value

|CHART               |APP VERSION  |
| ------------------ | ----------- |
|ingress-nginx-4.0.19|1.1.3        |

https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/

## Customize http-error

[ConfigMap](https://github.com/kubernetes/ingress-nginx/blob/main/docs/examples/customization/custom-errors/custom-default-backend-error_pages.configMap.yaml)

## Prometheus Query

Per-pod CPU usage in percentage
```bash
100 * max(
  rate(container_cpu_usage_seconds_total{namespace="ingress-nginx"}[5m])
    / on (container, pod)
  kube_pod_container_resource_limits{resource="cpu"}
) by (pod)
```

Per-pod Memory usage in percentage
```bash
100 * max(
  container_memory_working_set_bytes{namespace="ingress-nginx"}
    / on (container, pod)
  kube_pod_container_resource_limits{resource="memory"}
) by (pod)
```
