set -e

export gcp_project_id="project_id"
export gcp_region="region"
export gcp_zone="zone"

# google credentials
echo 'export GOOGLE_APPLICATION_CREDENTIALS="path_to_credentials"' >> $HOME/.bashrc

# Terraform variables
echo "export TF_VAR_project=$gcp_project_id" >> $HOME/.bashrc

echo "export TF_VAR_region=$gcp_region" >> $HOME/.bashrc
echo "export TF_VAR_zone=$gcp_zone" >> $HOME/.bashrc

echo 'export TF_VAR_data_lake_name="bucket_name"' >> $HOME/.bashrc
echo 'export TF_VAR_spark_scripts_name="script_folder"' >> $HOME/.bashrc

echo 'export TF_VAR_processed_folder="transform_folder"' >> $HOME/.bashrc
echo 'export TF_VAR_bq_dataset_name="bigquery_dataset"' >> $HOME/.bashrc
echo 'export TF_VAR_bq_table_name="bigquery_table"' >> $HOME/.bashrc

source $HOME/.bashrc