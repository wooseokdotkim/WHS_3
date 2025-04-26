#!/bin/bash

POD_NAME=cluster-pod
NAMESPACE=kube-system

TOKEN=$(kubectl exec $POD_NAME -- cat /var/run/secrets/kubernetes.io/serviceaccount/token)

APISERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')

separator() {
  echo -e "\n==================== $1 ====================\n"
}

separator "GET Pods in namespace '$NAMESPACE'"
curl -s -k -H "Authorization: Bearer $TOKEN" \
  "$APISERVER/api/v1/namespaces/$NAMESPACE/pods" | jq
  #  "$APISERVER/api/v1/pods" | jq


separator "GET All Namespaces"
curl -s -k -H "Authorization: Bearer $TOKEN" \
  "$APISERVER/api/v1/namespaces" | jq

