resource "helm_release" "prometheus" {
  depends_on       = [module.eks]
  chart            = "prometheus"
  name             = "prometheus"
  namespace        = "grafana"
  repository       = "https://prometheus-community.github.io/helm-charts"
  create_namespace = true
  timeout          = 1000

  # When you want to directly specify the value of an element in a map you need \\ to escape the point.
  set {
    name  = "podSecurityPolicy\\.enabled"
    value = true
  }

  set {
    name  = "server\\.persistentVolume\\.enabled"
    value = false
  }

  set {
    name = "server\\.resources"
    # You can provide a map of value using yamlencode  
    value = yamlencode({
      limits = {
        cpu    = "200m"
        memory = "50Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "30Mi"
      }
    })
  }
}

data "template_file" "grafana_values" {
  template = file("./grafana-values.yaml")

  vars = {
    GRAFANA_SERVICE_ACCOUNT = "grafana"
    GRAFANA_ADMIN_USER      = var.grafana_user
    GRAFANA_ADMIN_PASSWORD  = var.grafana_pwd
    PROMETHEUS_SVC          = "${helm_release.prometheus.name}-server"
    NAMESPACE               = "grafana"
  }
}

resource "helm_release" "grafana" {
  chart            = "grafana"
  name             = "grafana"
  verify           = false
  repository       = "https://grafana.github.io/helm-charts"
  namespace        = "grafana"
  create_namespace = true
  timeout          = 1000
  values = [
    data.template_file.grafana_values.rendered
  ]
}