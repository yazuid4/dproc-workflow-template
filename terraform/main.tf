module "transform" {
    source = "./modules/transform"

    project = var.project
    region  = var.region
    zone    = var.zone
    data_lake_name = var.data_lake_name
    spark_scripts_name = var.spark_scripts_name
}


module "bigquery" {
    source = "./modules/bigquery"

    data_lake_name   = var.data_lake_name
    bq_dataset_name  = var.bq_dataset_name
    bq_table_name    = var.bq_table_name
    processed_folder = var.processed_folder
}