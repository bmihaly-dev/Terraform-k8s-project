resource "kubernetes_namespace" "app" {
  metadata { name = var.namespace }
}

resource "kubernetes_deployment" "web_app" {
  metadata {
    name      = "web-app"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = { app = "web-app" }
  }
  spec {
    replicas = 2
    selector { match_labels = { app = "web-app" } }
    template {
      metadata { labels = { app = "web-app" } }
      spec {
        container {
          name  = "web-app"
          image = local.web_app_uri

          # Helyes indítás:
          command = ["node"]
          args    = ["/app/index.js"]

          env {
            name  = "PORT"
            value = "8080"
          }

          port { container_port = 8080 }

          liveness_probe {
            http_get {
              path = "/"
              port = 8080
            }
            initial_delay_seconds = 10
            period_seconds        = 10
          }
          readiness_probe {
            http_get {
              path = "/"
              port = 8080
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }

          resources {
            requests = { cpu = "100m", memory = "128Mi" }
            limits   = { cpu = "500m", memory = "512Mi" }
          }
        }
      }
    }
    
  }
}

resource "kubernetes_deployment" "auth_api" {
  metadata {
    name      = "auth-api"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = { app = "auth-api" }
  }
  spec {
    replicas = 2
    selector { match_labels = { app = "auth-api" } }
    template {
      metadata { labels = { app = "auth-api" } }
      spec {
        container {
          name  = "auth-api"
          image = local.auth_api_uri

          # Helyes indítás:
          command = ["node"]
          args    = ["/app/index.js"]

          env {
            name  = "PORT"
            value = "8080"
          }

          port { container_port = 8080 }

          liveness_probe {
            http_get {
              path = "/"
              port = 8080
            }
            initial_delay_seconds = 10
            period_seconds        = 10
          }
          readiness_probe {
            http_get {
              path = "/"
              port = 8080
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }

          resources {
            requests = { cpu = "100m", memory = "128Mi" }
            limits   = { cpu = "500m", memory = "512Mi" }
          }
        }
      }
    }
  }
}