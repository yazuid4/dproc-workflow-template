SELECT 
   {{ dbt_utils.generate_surrogate_key(["sensor_index"]) }} AS sensor_id,
   sensor_index,
   name,
   location_type,
   model,
   date_created
FROM {{ source("Silver", "sensors_data_silver") }}