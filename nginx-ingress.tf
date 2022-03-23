resource "helm_release" "nginix-ingress" {
  depends_on = [
    module.eks
  ]
  name      = "ingress-nginx"    
  repository = "https://kubernetes.github.io/ingress-nginx"    
  chart     = "ingress-nginx"
  namespace = "ingress-nginx"
  timeout = 1000
  create_namespace   = true
}