import argparse
from datetime import datetime
from pyspark.sql import SparkSession, functions as F
from pyspark.sql.types import StructType, StructField, StringType, \
                DoubleType, IntegerType, TimestampType



sensors_data_schema = StructType([
        StructField("sensor_index", StringType(), True),
        StructField("date_created", TimestampType(), True),
        StructField("last_seen", TimestampType(), True),
        StructField("name", StringType(), True),
        StructField("location_type", StringType(), True),
        StructField("model", StringType(), True),
        StructField("latitude", DoubleType(), True),
        StructField("longitude", DoubleType(), True),
        StructField("altitude", DoubleType(), True),
        StructField("confidence", IntegerType(), True),
        StructField("humidity", IntegerType(), True),
        StructField("temperature", IntegerType(), True),
        StructField("pressure", DoubleType(), True),
        StructField("pm1.0", DoubleType(), True),
        StructField("pm2.5", DoubleType(), True),
        StructField("pm10.0", DoubleType(), True),
        StructField("pm2.5_10minute", DoubleType(), True),
        StructField("pm2.5_30minute", DoubleType(), True),
        StructField("pm2.5_60minute", DoubleType(), True),
        StructField("pm2.5_6hour", DoubleType(), True),
        StructField("pm2.5_24hour", DoubleType(), True),
        StructField("pm2.5_1week", DoubleType(), True),
        StructField("scattering_coefficient", DoubleType(), True),
        StructField("deciviews", DoubleType(), True),
        StructField("visual_range", DoubleType(), True),
        StructField("state", StringType(), True),
        StructField("extract_ts", TimestampType(), True),
        StructField("data_ts", TimestampType(), True)
])




def job(args):

    spark = SparkSession.builder \
                .appName("test") \
                .getOrCreate()
    
    ingest_day = args.ingest_day
    
    if not ingest_day:
        ingest_day = datetime.now().strftime("%Y-%m-%d")
    
    source_path = f"gs://{args.bucket_name}/{args.source_path}/{ingest_day}"
    target_path = f"gs://{args.bucket_name}/{args.target_path}"
    
    df_sensors = spark.read.option("multiline", "true").json(source_path)

    # start processing
    df = (
        df_sensors.withColumn("row", F.explode("data"))
        .select(
            "row",
            "fields",
            "state",
            F.to_timestamp(F.from_unixtime("time_stamp")).alias("extract_ts"),
            F.to_timestamp(F.from_unixtime("data_time_stamp")).alias("data_ts")
        )
    )

    columns = df_sensors.select("fields").first()["fields"]

    df = df.select(
        *[
            F.col("row")[i].alias(columns[i])
            for i in range(len(columns))
        ],
        "state",
        "extract_ts", "data_ts"
    )

    df = df.withColumn(
                "date_created",
                F.to_timestamp(F.from_unixtime(F.col("date_created").cast("long")))
            ).withColumn(
                "last_seen",
                F.to_timestamp(F.from_unixtime(F.col("last_seen").cast("long")))
            )

    # apply schema
    df = df.select(
        *[
            F.col(f"`{field.name}`").cast(field.dataType).alias(field.name)
            for field in sensors_data_schema.fields
        ]
    )

    df = df.withColumn("ingest_on", F.lit(ingest_day))

    df = df.repartition("state")

    df.write.mode("append") \
            .option("header", "true") \
            .option("quote", '"') \
            .option("escape", '"') \
            .partitionBy("ingest_on", "state") \
            .csv(target_path)



if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Transfrom job parameters")

    parser.add_argument("--bucket_name", required=True)
    parser.add_argument("--source_path", required=True)
    parser.add_argument("--target_path", required=True)
    parser.add_argument("--compression", required=False)
    parser.add_argument("--ingest_day", required=False)

    args = parser.parse_args()
    job(args)