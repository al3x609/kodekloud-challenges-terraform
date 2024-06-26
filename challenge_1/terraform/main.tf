# main.tf
resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"
    labels = {
      name = "frontend"
    }
  }

  spec {
    replicas = 4

    selector {
      match_labels = {
        name = "webapp"
      }
    }

    template {
      metadata {
        labels = {
          name = "webapp"
        }
      }

      spec {
        container {
          image = "kodekloud/webapp-color:v1"
          name  = "simple-webapp"
          port {
            container_port = 8080
            protocol = "TCP"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "webapp-service" {
  metadata {
    name = "webapp-service"
  }

  spec {
    selector = {
      name = kubernetes_deployment.frontend.spec.0.template.0.metadata.0.labels.name
    }

    port {
      port        = 8080
      target_port = 8080
      node_port = 30080
    }

    type = "NodePort"
  }
}

