#!/bin/bash

echo "-------------------------------------------------------------"
echo "Database Setup...!!"
kubectl create ns mysql
kubectl create ns mongodb
echo "---------------------"
echo "namespace created for mysql and mongodb"
echo "-------------------------------------------------------------"
sudo mkdir -p /data/mysql
echo "-------------------------------------------------------------"
echo "First Setup MYSQL DataBase..!"
kubectl apply -f mysql.yaml -n mysql
echo "-------------------------------------------------------------"
kubectl get pods -n mysql
echo "-------------------------------------------------------------"
kubectl get pv,pvc -n mysql
echo "-------------------------------------------------------------"
sudo mkdir -p /data/mongodb
echo "-------------------------------------------------------------"
kubectl apply -f mongodb.yaml -n mongodb
echo "-------------------------------------------------------------"
kubectl get pods -n mongodb
kubectl get pv,pvc -n mongodb 
echo "-------------------------------------------------------------"


