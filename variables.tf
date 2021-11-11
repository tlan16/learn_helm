variable "kind_cluster_name" {
    type        = string
    description = "The name of the cluster."
    default     = "demo-local"
}

variable "kind_cluster_config_path" {
    type        = string
    description = "The location where this cluster's kubeconfig will be saved to."
    default     = "~/.kube/config"
}

# https://github.com/kubernetes/ingress-nginx/releases
variable "ingress_nginx_helm_version" {
    type        = string
    description = "The Helm version for the nginx ingress controller."
    default     = "4.0.6"
}

variable "ingress_nginx_namespace" {
    type        = string
    description = "The nginx ingress namespace (it will be created if needed)."
    default     = "ingress-nginx"
}
