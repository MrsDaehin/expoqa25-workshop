####Kubernetes will respect the PDB and prevent disruptions that violate it.
###error when evicting pods/"nginx-deployment-96b9d695-vgblj" -n "default" (will retry after 5s): Cannot evict pod as it would violate the pod's disruption budget.
kubectl drain k8s-pdb-m02 --ignore-daemonsets --delete-emptydir-data
