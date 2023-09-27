# ArgoCD Installing
## Prerequisites

Before you begin, ensure you have the following prerequisites:

- A Kubernetes cluster up and running.
- The `kubectl` command-line tool installed and configured to access your cluster.
- The `argocd` command-line tool (CLI) installed (optional but recommended).
- Helm installed on your local machine (for Helm installation method).

## Installation Steps

### Helm Installation

1. Add the ArgoCD Helm repository:

   ```bash
   helm repo add argo https://argoproj.github.io/argo-helm
      ```
# Install ArgoCD:

   ```bash

kubectl create namespace argocd
helm install argocd argo/argo-cd --namespace argocd
#Wait for ArgoCD pods to be in a running state:

kubectl get pods -n argocd
#Access the ArgoCD Web UI Get the ArgoCD admin password:

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
   ```

Access the ArgoCD web UI by port-forwarding to the service:
   ```bash

kubectl port-forward svc/argocd-server -n argocd 8000:443
   ```

Open a web browser and navigate to http://localhost:8000. Log in using the admin username and password obtained in the previous step.

## Uninstallation of ArgoCD
To uninstall ArgoCD, use the following commands:

   ```bash
helm uninstall argocd -n argocd
kubectl delete namespace argocd
   ```


![Description](ARGO.jpg)


