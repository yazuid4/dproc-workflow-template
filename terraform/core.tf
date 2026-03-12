resource "google_service_account" "dataproc_service_account" {
  account_id   = "${var.project}-dproc-sa"
  display_name = "Service Account for Dataproc"
}

resource "google_project_iam_member" "dataproc_roles" {
  for_each = toset([
    "roles/dataproc.worker",       
    "roles/storage.admin",         
    "roles/logging.logWriter",     
    "roles/monitoring.metricWriter"
  ])
  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.dataproc_service_account.email}"
}