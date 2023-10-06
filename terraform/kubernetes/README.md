# Install Kubernetes on local Macbook

### Use the package manager homebrew to install kind.
```
brew install kind
```

### Download and save the kind configuration into a file named kind-config.yaml. This configuration adds extra port mappings, so you can access the NGINX service locally later.
```
curl https://raw.githubusercontent.com/hashicorp/learn-terraform-deploy-nginx-kubernetes-provider/main/kind-config.yaml --output kind-config.yaml
```

### Then, create a kind Kubernetes cluster.
```
kind create cluster --name terraform-learn --config kind-config.yaml
```

### Verify that your cluster exists by listing your kind clusters.
```
kind get clusters
```

### Then, point kubectl to interact with this cluster. The context is kind- followed by the name of your cluster.
```
kubectl cluster-info --context kind-terraform-learn
```

### Create a directory named learn-terraform-deploy-nginx-kubernetes.
```
mkdir learn-terraform-deploy-nginx-kubernetes
```

### Then, navigate into it
```
cd learn-terraform-deploy-nginx-kubernetes
```

### Then, create a new file named kubernetes.tf and add the following configuration to it. This serves as a base configuration for the provider.

### To properly configure this provider, you need to define the variables.

### First, view your kind cluster information.
```
kubectl config view --minify --flatten --context=kind-terraform-learn
```

### You should end up with something similar to the following.
```
host                   = "https://127.0.0.1:32768"
client_certificate     = "LS0tLS1CRUdJTiB..."
client_key             = "LS0tLS1CRUdJTiB..."
cluster_ca_certificate = "LS0tLS1CRUdJTiB..."
```

### Host port number could be different. Check the port number is same in the var file.

### After configuring the provider, run terraform init to download the latest version and initialize your Terraform workspace.
```
terraform init
```

### Run plan and apply to deploy
```
terraform plan
terraform apply
```

### Once the apply is complete, verify the NGINX deployment is running and verify the NGINX service is running.
```
kubectl get deployments
kubectl get services
```

### You can access the NGINX instance by navigating to the NodePort at http://localhost:30201/