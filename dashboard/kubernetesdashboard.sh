#!/bin/bash

echo "-------------------------------------------------------------"
echo "Dashboard Setup...!!"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

echo "-------------------------------------------------------------"
kubectl apply -f clusterbinding.yaml

echo "-------------------------------------------------------------"
kubectl -n kubernetes-dashboard create token admin-user

echo "-------------------------------------------------------------"
echo "copy the access token"

echo "-------------------------------------------------------------"
kubectl get pods -A -o wide
echo "-------------------------------------------------------------"
kubectl proxy
echo "-------------------------------------------------------------"
echo "go to this url"
echo "-------------------------------------------------------------"
echo "http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login"

echo "-------------------------------------------------------------"
echo "Done.......!!"
