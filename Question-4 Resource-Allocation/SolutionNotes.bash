# Step 1: pause workload
kubectl scale deployment wordpress --replicas 0

# Step 2: set requests/limits (e.g., 250m/300m CPU, 500Mi/600Mi mem)
kubectl patch deployment wordpress -p '{
  "spec":{"template":{"spec":{
    "containers":[{
      "name":"wordpress",
      "resources":{
        "requests":{"cpu":"250m","memory":"500Mi"},
        "limits":{"cpu":"300m","memory":"600Mi"}
      }
    }]
  }}}}'

# Step 3: resume replicas
kubectl scale deployment wordpress --replicas 3
kubectl get pods -l app=wordpress
