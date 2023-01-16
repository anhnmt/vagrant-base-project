#!/bin/sh

# instal k8s
sudo apt-get update
sudo apt-get install -y ca-certificates curl

sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet=1.24.0-00 kubeadm=1.24.0-00 kubectl=1.24.0-00
sudo apt-mark hold kubelet kubeadm kubectl

kubectl version --client && kubeadm version

# disable swap
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo nano /etc/fstab

sudo swapoff -a
sudo mount -a
free -h

sudo modprobe overlay
sudo modprobe br_netfilter

sudo sysctl --system

kubectl get nodes

sudo systemctl enable kubelet --now