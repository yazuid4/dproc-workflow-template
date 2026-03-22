
resource "google_dataproc_workflow_template" "sensors_etl_job" {
  name     = "${var.project}-sensors-etl-job"
  location = var.region

  placement {
    managed_cluster {
      cluster_name = "${var.project}-etl-cluster"
      config {
        gce_cluster_config {
          # zone            = var.zone
          service_account = google_service_account.dataproc_service_account.email
          internal_ip_only = false 
        }
        
        master_config {
          num_instances = 1
          machine_type  = "e2-standard-2"
        }

        worker_config {
          num_instances = 2
          machine_type  = "e2-standard-2"
        }

        software_config {
          image_version = "2.1-debian11"
        }
      }
    }
  }

  jobs {
    step_id = "sensors-data-transform"
    pyspark_job {
      main_python_file_uri = "gs://${var.data_lake_name}/${var.spark_scripts_name}/process_sensors_data.py"
      
      # arguments
      args = [
        "--s3_bucket", var.data_lake_name,
        "--source_path", "source/",
        "--target_path", "processed/",
        "--compression", "snappy",
      ]

      properties = {
        "spark.rpc.message.maxSize" = "2000"
      }
    }
  }
}


