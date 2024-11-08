resource "google_sql_database_instance" "primary" {
  project = var.project_id
  name = "postgres-database"
  database_version = "POSTGRES_14"
  region = var.region
}