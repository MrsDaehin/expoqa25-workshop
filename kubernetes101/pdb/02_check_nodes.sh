kubectl get nodes

kubectl get nodes -o wide

kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}'

