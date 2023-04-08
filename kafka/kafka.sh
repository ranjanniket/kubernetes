#!/bin/bash

echo "-------------------------------------------------------------"
kubectl create ns kafka
echo "Namespace create"
echo "-------------------------------------------------------------"
kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka'
echo "-------------------------------------------------------------"
kubectl get pods -n kafka
echo "-------------------------------------------------------------"
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X
echo "-------------------------------------------------------------"
kubectl apply -f kafka.yaml -n kafka
echo "-------------------------------------------------------------"
kubectl get pods -n kafka
echo "-------------------------------------------------------------"
kubectl get svc -n kafka
echo "-------------------------------------------------------------"
echo "check bootstrap server is created or not and copy the IP address and port"
echo "-------------------------------------------------------------"
echo "wait for 5 minutes..!!"
echo "-------------------------------------------------------------"
echo "copy the bootstrap ip and paste in kowl value: {bootstrap_ip}:9098"
echo "-------------------------------------------------------------"
echo "After this kubectl apply -f kowl -n kafka : Do manually"





