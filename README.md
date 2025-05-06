# expoqa25-workshop
Workshop de 4 horas


🎯 Objetivo

Entender cómo tunear y optimizar el rendimiento del cluster de Kubernetes y aplicaciones para asegurar el consumo eficiente de recursos y alto rendimiento. 



🔑 Conceptos de Escalabilidad en K8s

Resource y Requests Limits
HPA
VPA
Afinidad de Node / Pod 
Storage
Probes Ready, Alive y StartUp
Monitoring y Profiling

🧪 Laboratorio

Configurar Resource Requests y Limits para los pods
	Problemas asociados: CPU Throttling
	
Implementar HPA 
	Ejemplo con Keda con Prometheus
	Pod Disruptor Budget

Definir VPA

Configurar Node y Pod Afinidad y Anti Afinidad para pruebas de Avalancha

Optimización de Storage	
	Stateful Set y Storage Classes

Implementar y configurar Monitorización y Profiling	
	Instalar Prometheus y Grafana para monitorización.
	Recoger y analizar performance metrics para identificar cuellos de botella. 
	
Los tests los realizaremos con K6 en local y el SUT será un K8s local ( minikube con dos nodos ) o killercoda.com en Internet
	
https://killercoda.com/playgrounds/scenario/kubernetes
