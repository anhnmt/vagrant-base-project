#!/bin/sh

sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update

#sudo apt-get install -y docker-ce=5:20.10.22~3-0~ubuntu-bionic docker-ce-cli=5:20.10.22~3-0~ubuntu-bionic containerd.io=1.6.15-1 docker-compose-plugin=2.14.1~ubuntu-bionic
#sudo apt-mark hold docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo apt-get install -y containerd.io=1.6.15-1

sudo apt-mark hold containerd.io

# default configuration file for containerd
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml

sudo systemctl restart containerd
sudo systemctl enable containerd
# 	sudo systemctl status containerd

sudo usermod -aG docker $USER

sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF