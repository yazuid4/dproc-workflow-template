SELECT 
    {{ dbt_utils.generate_surrogate_key([
        "sensor_index",
        "CAST(last_seen AS STRING)"]) }} AS Id,

    {{ dbt_utils.generate_surrogate_key([
        "sensor_index"
    ]) }} AS sensor_id,

    {{ dbt_utils.generate_surrogate_key([
        "CAST(ROUND(latitude, 4) AS STRING)",
        "CAST(ROUND(longitude, 4) AS STRING)"]) }} AS location_id,

    DATE(TIMESTAMP(last_seen)) AS event_date,
    
    pm1_0,
    pm2_5,
    pm10_0,
    pm2_5_10minute,
    pm2_5_30minute,
    pm2_5_60minute,
    pm2_5_6hour,
    pm2_5_24hour,
    pm2_5_1week,
    confidence,
    humidity,
    temperature,
    pressure,
    scattering_coefficient,
    deciviews,
    visual_range,
    state AS measurement_p_state,
    last_seen AS measurement_ts

FROM {{ source("Silver", "sensors_data_silver") }}