**Prerequisites**
Before you begin, ensure you have the following prerequisites:

A Kubernetes cluster up and running.
kubectl command-line tool installed and configured to access your cluster.
argocd command-line tool (CLI) installed (optional but recommended).
Helm installed on your local machine (for Helm installation method).

**Installation Steps**

**Helm Installation **

Add the ArgoCD Helm repository:

- helm repo add argo https://argoproj.github.io/argo-helm

**Install ArgoCD:**

- kubectl create namespace argocd
- helm install argocd argo/argo-cd --namespace argocd

Wait for ArgoCD pods to be in a running state:

- kubectl get pods -n argocd


**Get the ArgoCD admin password:**

- kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
**Access the ArgoCD web UI by port-forwarding to the service:**

- kubectl port-forward svc/argocd-server -n argocd 8000:443
Now, open a web browser and navigate to http://localhost:8000 and log in using the admin username and password in privous Steps

**Uninstallation ArgoCD**

To uninstall ArgoCD, use the following commands:

- helm uninstall argocd -n argocd
- kubectl delete namespace argocd

