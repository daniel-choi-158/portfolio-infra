provider "kubernetes" {}

resource "kubernetes_deployment" "portfolio-frontend" {
  metadata {
    name = "portfolio-frontend-deployment"
    labels = {
      App = "portfolio-frontend"
    }
  }

  spec {
    replicas = 4
    selector {
      match_labels = {
        App = "portfolio-frontend"
      }
    }
    template {
      metadata {
        labels = {
          App = "portfolio-frontend"
        }
      }
      spec {
        container {
          image = "danielchoi158/portfolio-frontend:latest"
          name  = "portfolio-frontend-container"

          port {
            container_port = 80
          }

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "portfolio-frontend-service" {
  metadata {
    name = "portfolio-frontend-service"
  }
  spec {
    selector = {
      App = kubernetes_deployment.portfolio-frontend.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

output "lb_ip" {
  value = kubernetes_service.portfolio-frontend-service.load_balancer_ingress[0].ip
}