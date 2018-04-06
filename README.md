# TSI Kubernetes

A Terraform + Ansible combo to install a basic kubernetes setup on the EMBASSY openstack cloud.

## Instructions
Copy `terraform/tfvars.example` to `terraform/terraform.tfvars` and edit to your liking. Then run:

`terraform apply` and confirm when prompted.

If everything has deployed successfully, cd into the `ansible` directory and run:

`ansible-playbook -i inventory.ini -u centos cluster.yml`

By default this playbook installs Kubernetes 1.9 with docker 1.12, however modify the `versions.yml` file to adjust this. The playbook also uses Weave as a network plugin.

SSH into your master node and run `kubectl get pods --all-namespaces` to check everything is ok, you should see something similar to this:

```bash
[centos@k8s-basic-test-master ~]$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                            READY     STATUS    RESTARTS   AGE
kube-system   etcd-k8s-basic-test-master                      1/1       Running   0          1m
kube-system   kube-apiserver-k8s-basic-test-master            1/1       Running   0          1m
kube-system   kube-controller-manager-k8s-basic-test-master   1/1       Running   0          2m
kube-system   kube-dns-6f4fd4bdf-d4s2c                        3/3       Running   0          2m
kube-system   kube-proxy-f2792                                1/1       Running   0          2m
kube-system   kube-proxy-mvs9x                                1/1       Running   0          2m
kube-system   kube-proxy-zdhzf                                1/1       Running   0          2m
kube-system   kube-scheduler-k8s-basic-test-master            1/1       Running   0          2m
kube-system   weave-net-2khj6                                 2/2       Running   1          2m
kube-system   weave-net-cbwbt                                 2/2       Running   0          2m
kube-system   weave-net-pgmzm                                 2/2       Running   1          2m
```

Take special care if your weave or dns pods have a high number of restarts or are in an error state, this indicates networking issues. Re-check your terraform ip setup and/or try a different network adapter for Kubernetes as described [here](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#pod-network).
