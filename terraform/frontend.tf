resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "notes-frontend"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "notes-frontend"
      }
    }
    template {
      metadata {
        labels = {
          app = "notes-frontend"
        }
      }
      spec {
        container {
         
          image = "ilyaslog/notes-frontend:latest"
          name  = "notes-frontend"
          image_pull_policy = "Always" 

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  metadata {
    name = "notes-frontend"
  }
  spec {
    selector = {
      app = "notes-frontend"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}

