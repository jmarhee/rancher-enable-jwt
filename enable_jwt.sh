#!/bin/bash

RANCHER_API_URL=$RANCHER_API_URL # Do not set /v1 or /v3 URI here
RANCHER_ACCESS_KEY=$RANCHER_ACCESS_KEY
RANCHER_SECRET_KEY=$RANCHER_SECRET_KEY
CLUSTER_NAME=$1

# Retrieve Cluster ID from Rancher
clusters_response=$(curl --insecure -s -u "$RANCHER_ACCESS_KEY:$RANCHER_SECRET_KEY" -X GET \
  -H "Content-Type: application/json" \
  "$RANCHER_API_URL/v3/clusters?name=$CLUSTER_NAME")

target_cluster_id=$(echo "$clusters_response" | jq -r '.data[] | select(.name=="'"$CLUSTER_NAME"'") | .id')

if [ -z "$target_cluster_id" ]; then
  echo "Cluster with name '$CLUSTER_NAME' not found."
  exit 1
else
  echo "Cluster ID for '$CLUSTER_NAME' is '$target_cluster_id'."
fi

CLUSTER_ID=$target_cluster_id

curl --insecure -s -u "$RANCHER_ACCESS_KEY:$RANCHER_SECRET_KEY" -X POST \
  -H "Content-Type: application/json" \
  -d "{\"enabled\":true,\"metadata\":{\"namespace\":\"$CLUSTER_ID\",\"name\":\"clusterproxyconfig\"}}"\
 "$RANCHER_API_URL/v1/management.cattle.io.clusterproxyconfigs"
