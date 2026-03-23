SELECT
    {{ dbt_utils.generate_surrogate_key([
        "CAST(ROUND(latitude, 4) AS STRING)",
        "CAST(ROUND(longitude, 4) AS STRING)"
    ]) }} AS location_id,
    
    ROUND(latitude, 4)  AS latitude,
    ROUND(longitude, 4) AS longitude,
    altitude

FROM {{ source("Silver", "sensors_data_silver") }}