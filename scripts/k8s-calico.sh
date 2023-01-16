#!/bin/sh

# install Calico
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml

#kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/tigera-operator.yaml
#kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/custom-resources.yaml

#watch kubectl get pods --all-namespaces

kubectl get nodes