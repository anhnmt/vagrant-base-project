#!/bin/sh

# init cluster master
sudo kubeadm init --pod-network-cidr 192.168.0.0/16 --kubernetes-version 1.24.0

sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get nodes

kubectl cluster-info

# kubeadm token create --print-join-command

## Cho phép Pod có thể chạy trên master node
#kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# kubectl get cm kubeadm-config -n kube-system -o yaml