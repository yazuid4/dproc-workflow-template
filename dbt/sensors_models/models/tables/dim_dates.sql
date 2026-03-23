SELECT
  DATE(TIMESTAMP(last_seen)) AS event_date,
  EXTRACT(YEAR  FROM TIMESTAMP(last_seen)) AS event_year,
  EXTRACT(MONTH FROM TIMESTAMP(last_seen)) AS event_month,
  EXTRACT(WEEK  FROM TIMESTAMP(last_seen)) AS event_week,
  EXTRACT(DAY   FROM TIMESTAMP(last_seen)) AS event_day,
  EXTRACT(HOUR  FROM TIMESTAMP(last_seen)) AS event_hour

FROM {{ source("Silver", "sensors_data_silver") }}