variable "project" {
  description = "The project Id"
  type = string
}

variable "region" {
  description = "Project region"
  type = string
}

variable "zone" {
  description = "Project zone"
  type = string
}

variable "data_lake_name" {
  description = "datalake bucket name"
  type = string
}

variable "spark_scripts_name" {
  type        = string
  description = "spark scripts folder"
}
