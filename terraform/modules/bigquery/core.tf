resource "google_bigquery_dataset" "sensors_dataset" {
  dataset_id = var.bq_dataset_name
  
  location   = "US"
  description = "dataset referencing processed sensors data"
  delete_contents_on_destroy = true
}


resource "google_bigquery_table" "sensors_table" {
    
    dataset_id = google_bigquery_dataset.sensors_dataset.dataset_id
    table_id = var.bq_table_name

    deletion_protection = false
    
    external_data_configuration { 
        source_format = "CSV" 
        source_uris = ["gs://${var.data_lake_name}/${var.processed_folder}/*"] 
        autodetect = true 
        
        hive_partitioning_options { 
            mode = "AUTO" 
            source_uri_prefix = "gs://${var.data_lake_name}/${var.processed_folder}/" 
        }
        
        csv_options { 
            skip_leading_rows = 1
            quote             = "\""
         }
    }
}