set -e

export gcp_project_id="<project_id>"
export gcp_region="<project_region>"
export gcp_zone="<project_zone>"

# google credentials
echo 'export GOOGLE_APPLICATION_CREDENTIALS="<path_to_service_account_key"' >> $HOME/.bashrc

# Terraform variables
echo "export TF_VAR_project=$gcp_project_id" >> $HOME/.bashrc

echo "export TF_VAR_region=$gcp_region" >> $HOME/.bashrc
echo "export TF_VAR_zone=$gcp_zone" >> $HOME/.bashrc

echo 'export TF_VAR_data_lake_name="<bucket_nameW"' >> $HOME/.bashrc
echo 'export TF_VAR_spark_scripts_name="<sctipt_folder>"' >> $HOME/.bashrc

source $HOME/.bashrc