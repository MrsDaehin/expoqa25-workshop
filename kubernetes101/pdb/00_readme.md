## POD DISRUPTION BUDGET

# What is a Pod Disruption Budget (PDB)?

A **Pod Disruption Budget (PDB)** is a Kubernetes object that limits the number of pods in a deployment, stateful set, or replica set that can be voluntarily disrupted at any given time.

Disruptions could be caused by:

* Node maintenance or upgrades
* Cluster autoscaling (scale-down events)
* Admin-triggered operations like `kubectl drain`

PDBs guarantee **a minimum number of running pods** (or restrict the maximum number of disrupted pods) during such operations.

# How Does a PDB Work in Kubernetes?

Kubernetes relies on the PDB to evaluate whether a disruption is permissible. If the disruption would cause the remaining number of pods to fall below the defined threshold, Kubernetes blocks the action.

For example:

* You have 5 replicas of a pod and set `minAvailable: 4`. If an operation tries to disrupt 2 pods, Kubernetes will block it because only 3 pods would remain, violating the PDB.

# Common Scenarios Without PDBs

1. **Cluster Upgrades** : During node updates, Kubernetes drains nodes (evicting pods). Without a PDB, critical applications might lose all pods on a node.
2. **Autoscaling Chaos** : Scaling down without a PDB can unintentionally remove all replicas of a critical service.
3. **Load Balancer Failures** : If all replicas of a backend service are disrupted, load balancers might start serving errors.

# Real-World Best Practices

1. **Start Small** : Test PDBs on non-critical workloads before applying them to production services.
2. **Balance Constraints** : Avoid setting `minAvailable` too high—it might block scaling or upgrades.
3. **Use with HPA** : Combine PDB with the Horizontal Pod Autoscaler to dynamically scale pods while ensuring availability.
4. **Review Regularly** : Update PDBs as traffic patterns or resource requirements change.
5. **Monitor Continuously** : Use monitoring tools like Prometheus, Grafana, or Lens to visualize PDB health.
