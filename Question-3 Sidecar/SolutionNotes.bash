# Add shared volume + sidecar to deployment
kubectl edit deployment wordpress   # add emptyDir volume and mounts below
# spec.template.spec.volumes:
# - name: log
#   emptyDir: {}
# main container volumeMounts:
# - mountPath: /var/log
#   name: log
# add sidecar:
# - name: sidecar
#   image: busybox:stable
#   command: ["/bin/sh","-c","tail -f /var/log/wordpress.log"]
#   volumeMounts:
#   - mountPath: /var/log
#     name: log
kubectl rollout status deployment wordpress
kubectl get pods -l app=wordpress

