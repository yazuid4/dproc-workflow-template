
variable "project" {
  description = "the project Id"
  type = string
}

variable "region" {
  description = "project region"
  type = string
}

variable "zone" {
  description = "project zone"
  type = string
}

variable "data_lake_name" {
  description = "datalake bucket name"
  type = string
}

variable "spark_scripts_name" {
  type        = string
  description = "spark scripts folder in the bucket"
}
