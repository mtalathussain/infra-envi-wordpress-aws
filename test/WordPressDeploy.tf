//CREATE DEPLOYMENT - provide rds environment variables
resource "kubernetes_deployment" "wordpress" {
  metadata {
    name = "wordpress"
    labels = {
      App = "wordpress"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "wordpress"
      }
    }
    template {
      metadata {
        labels = {
          App = "wordpress"
        }
      }
      spec {
        container {
          image = "wordpress:4.8-apache"
          name  = "wordpress"
		  env{
            name = "WORDPRESS_DB_HOST"
            value = aws_db_instance.rds.address
          }
          env{
            name = "WORDPRESS_DB_USER"
            value = aws_db_instance.rds.username
          }
          env{
            name = "WORDPRESS_DB_PASSWORD"
             value = aws_db_instance.rds.password
          }
		  env{
			name = "WORDPRESS_DB_DATABASE"
			value = aws_db_instance.rds.name
		  }
          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}


//EXPOSE DEPLOYMENT - This creates a LoadBalancer, which routes traffic from //the external load balancer to pods with the matching selector.

resource "kubernetes_service" "wordpress" {
  metadata {
    name = "wordpress"
  }
  spec {
    selector = {
      App = kubernetes_deployment.wordpress.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}


//OUTPUT
output "lb_ip" {
  value = kubernetes_service.wordpress.status.0
}