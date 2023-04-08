#!/bin/bash
echo "-------------------------------------------------------------"
echo "Updating Package manager........"
# Update package manager cache
sudo apt-get update
echo "-------------------------------------------------------------"
echo "Docker Installation"
echo "-------------------------------------------------------------"
# Install Docker
sudo apt-get install docker.io
sudo systemctl status docker
docker --version
sudo systemctl start docker
echo  "press q to end"
sudo systemctl status docker
echo "-------------------------------------------------------------"
echo "conatinerd installation"

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install containerd
sudo systemctl start conatinerd
sudo systemctl status conatinerd
echo "-------------------------------------------------------------"

echo "kubernetes installation"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
#sudo wget -O -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
echo "-------------------------------------------------------------"
echo "Updating Package manager........"
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
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
echo  "Done........"