#!/bin/bash


kubectl apply -f namespace.yaml
kubectl apply -f secrets/
kubectl apply -f ConfigMaps/
kubectl apply -f deployments/
kubectl apply -f services/
