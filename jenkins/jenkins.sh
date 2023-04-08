#!/bin/bash

echo "-------------------------------------------------------------"
echo "Jenkins Setup...!!"
kubectl create ns jenkins
echo "-------------------------------------------------------------"
sudo mkdir -p /var/jenkins_home
echo "-------------------------------------------------------------"
kubectl apply -f jenkins.yaml -n jenkins
echo "-------------------------------------------------------------"
echo "to get the password id see the logs of pod"
echo "kubectl logs {pod_name} -n jenkins"
echo "-------------------------------------------------------------"
kubectl get svc -n jenkins
echo "-------------------------------------------------------------"
echo "get the port number and with browser you are able to acces UI"
echo "Access Web UI: http://localhost:{port_number}/"
echo "-------------------------------------------------------------"
kubectl get pod -n jenkins
echo "-------------------------------------------------------------"