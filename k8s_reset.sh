#!/bin/bash

echo "-------------------------------------------------------------"
sudo systemctl start docker
echo  "press q to end"
sudo systemctl status docker

echo "-------------------------------------------------------------"
sudo systemctl start conatinerd
sudo systemctl status conatinerd
echo "-------------------------------------------------------------"
sudo apt-get update
sudo apt-get install ipvsadm
echo "-------------------------------------------------------------"
echo "press Y for yes"
sudo kubeadm reset
sudo rm -rf /etc/cni/net.d
sudo ipvsadm --clear
echo "-------------------------------------------------------------"
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab
echo "-------------------------------------------------------------"
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
echo "-------------------------------------------------------------"
echo "Making kubectl work for your non-root user"
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
echo "-------------------------------------------------------------"
echo "Remove taint from nodes..."
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
kubectl taint nodes --all node.kubernetes.io/not-ready:NoSchedule-
echo "-------------------------------------------------------------"
echo "Installing Network CNI......."
sudo curl https://docs.projectcalico.org/manifests/calico-typha.yaml -o calico.yaml
kubectl apply -f calico.yaml
echo "-------------------------------------------------------------"
kubectl get nodes 
kubectl get pods -A -o wide
echo "-------------------------------------------------------------"
echo  "Done........"