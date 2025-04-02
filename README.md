# Enable JWT for Rancher Managed Clusters

Requirements:
- Rancher Manager kubeconfig
- `kubectl` on client machine
- Rancher Token

This patch will be applied to the management cluster.

## Usage

Set:

```
export RANCHER_API_URL="https://rancher.tld/" # Do not set /v1 or /v3 URI here
export RANCHER_ACCESS_KEY="token-xxxx"
export RANCHER_SECRET_KEY="xxxxx"
```

which will be used to locate the cluster ID.

Set `export KUBECONFIG` to the local cluster (Rancher Manager) kubeconfig which will apply the patch, and using the cluster's UI friendly name:

```bash
./patch_jwt.sh cluster-name
```

and if successfully enabled, you will see a confirmation prompt:

```
clusterproxyconfig status for jwt (c-m-tsjkrjq6):
    "enabled": true,
```
