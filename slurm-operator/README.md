

1. Pull slurm-operator image
```shell
docker pull aaron666/slurm-operator:latest
```
> or maybe you need to load it into minikube, you can use `minikube image load xxx.dim`

2. Users can just run 'kubectl apply -f ' to install the operator, i.e.:
```shell
kubectl apply -f https://raw.githubusercontent.com/AaronYang0628/containers/refs/heads/main/slurm-operator/apply-operator.yaml
```

3. And then build the slurm cluster
```shell
kubectl apply -f https://raw.githubusercontent.com/AaronYang0628/containers/refs/heads/main/slurm-operator/install-slurm.yaml
```