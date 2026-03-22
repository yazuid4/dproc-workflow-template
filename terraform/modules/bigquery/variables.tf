variable "bq_dataset_name" {
    type        = string
    description = "bigquery dataset"
}

variable "bq_table_name" {
    type        = string
    description = "bigquery table"
}

variable "data_lake_name" {
   type         = string
   description  = "datalake bucket name"
}

variable "processed_folder" {
   type        = string
   description = "folder containing processed data"
}