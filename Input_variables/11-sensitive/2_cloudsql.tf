# Creating a cloud sql resource using terraform 
resource "google_sql_database_instance" "tf_sql_instance" {
  name = "my-sql-instance" # Cloud SQL instnace name, not db name
  database_version = "MYSQL_8_0"
  root_password = var.database_password # lets change again in variables
  deletion_protection = false
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name = "Allow-all"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_sql_database" "name" {
  name = "emp-database"
  instance = google_sql_database_instance.tf_sql_instance.name
}