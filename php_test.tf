resource "kubernetes_namespace" "testphp" {
  metadata {
    name = "test-php"
  }
}

resource "kubernetes_manifest" "test-php" {
  depends_on = [
    kubernetes_namespace.testphp,
    module.eks
  ]
manifest = yamldecode(<<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-world
  namespace: test-php
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello-world
  template:
    metadata:
      labels:
        app: hello-world
    spec:
      containers:
      - image: okteto/hello-world:php
        name: hello-world
YAML
)
}

resource "kubernetes_manifest" "test-php-svc" {
  depends_on = [
    kubernetes_namespace.testphp,
    module.eks
  ]
manifest = yamldecode(<<YAML
apiVersion: v1
kind: Service
metadata:
  name: hello-world
  namespace: test-php
  annotations:
    dev.okteto.com/auto-ingress: "true"
spec:
  type: ClusterIP  
  ports:
  - name: "hello-world"
    port: 8080
  selector:
    app: hello-world
YAML
)
}

resource "kubernetes_manifest" "test-php-ing" {
  depends_on = [
    kubernetes_manifest.test-php-svc,
    module.eks
  ]
manifest = yamldecode(<<YAML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-world
  namespace: test-php
spec:
  rules:
  - host: "test-php.${var.domain_name}"
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: hello-world
            port:
              number: 8080
  ingressClassName: nginx
YAML
)
}
