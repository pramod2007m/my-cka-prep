# Step 1: free the PV if Released
kubectl describe pv mariadb-pv
kubectl edit pv mariadb-pv   # remove claimRef block so status becomes Available

# Step 2: create PVC with no storageClass
cat <<'EOF' > pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mariadb
  namespace: mariadb
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 250Mi
  storageClassName: ""
EOF
kubectl apply -f pvc.yaml
kubectl get pvc mariadb -n mariadb
kubectl get pv mariadb-pv     # should show Bound to mariadb

# Step 3: ensure deployment uses the PVC
# mariadb-deploy.yaml should mount claimName: mariadb
kubectl apply -f mariadb-deploy.yaml
kubectl get pods -n mariadb
