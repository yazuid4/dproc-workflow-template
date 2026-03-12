# dproc-workflow-template

Automated ETL pipeline that ingests raw PurpleAir sensor data into Google Cloud Storage and utilizes Dataproc Spark jobs—provisioned and managed via Terraform—to transform and partition data by event date and state.