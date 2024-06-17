# helm_charts/main.tf
# 定义并配置 kubernetes provider
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# 定义并配置 helm provider
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}


resource "helm_release" "keda" {
  provider         = helm
  name             = "keda"
  repository       = "https://kedacore.github.io/charts"
  chart            = "keda"
  version          = "2.12.1"
  namespace        = "keda"
  create_namespace = true
}

resource "helm_release" "kube-prometheus" {
  provider         = helm
  name             = "kube-prometheus"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "kube-prometheus"
  version          = "9.0.7"
  namespace        = "monitor"
  create_namespace = true
}


# resource "helm_release" "kube-events-exporter" {
#   provider         = helm
#   name             = "kube-events-exporter"
#   repository       = "https://charts.bitnami.com/bitnami"
#   chart            = "kubernetes-event-exporter"
#   version          = "3.0.5"
#   namespace        = "logs"
#   create_namespace = true
# }

resource "helm_release" "kube-events-exporter" {
  provider         = helm
  name             = "kube-events"
  chart            = "../../charts/kubernetes-event-exporter"
  namespace        = "logs"
  create_namespace = true
}

resource "helm_release" "elasticsearch" {
  provider         = helm
  name             = "elasticsearch"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "elasticsearch"
  version          = "21.0.4"
  namespace        = "logs"
  create_namespace = true
}

resource "helm_release" "kibana" {
  provider         = helm
  name             = "kibana"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "kibana"
  version          = "11.0.6"
  namespace        = "logs"
  create_namespace = true
  set {
    name  = "elasticsearch.hosts[0]"
    value = "elasticsearch"
  }

  set {
    name  = "elasticsearch.port"
    value = "9200"
  }
}

resource "helm_release" "vault" {
  provider         = helm
  name             = "vault"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  version          = "0.28.0"
  namespace        = "vault"
  create_namespace = true
}
