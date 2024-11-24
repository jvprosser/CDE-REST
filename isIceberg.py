from pyspark.sql import SparkSession

import sys
import configparser



#
#config = configparser.ConfigParser()
#config.read('/app/mount/{}.properties'.format(sys.argv[3]))
#property_1=config.get("general","property_1")
#property_2=config.get("general","property_2")


def is_iceberg_table(spark, dbname, table_name):
    try:
        # Try to read the table properties
        properties = spark.sql(f"SHOW TBLPROPERTIES {dbname}.{table_name}").collect()

        # Check if 'format' property exists and is set to 'iceberg'
        for row in properties:
            if row['key'] == 'format' and row['value'].startswith("iceberg"):
		return True

            # If 'format' property is not found or not set to 'iceberg'
            return False
    except Exception as e:
        print(f"Error checking table: {str(e)}")
	return False


if __name__ == '__main__':

    print("JOB ARGUMENTS")
    print(sys.argv)
    print(sys.argv[0])
    print(sys.argv[1])
    print(sys.argv[2])


    dbname=sys.argv[1]
    table_name=sys.argv[2]
    USER_PREFIX="JVP"
#    data_lake_name=
#         .config("spark.yarn.access.hadoopFileSystems", data_lake_name)

    spark = (
	SparkSession.builder.appName(f"{USER_PREFIX}_CCLead-Data-Loader")
	.config("spark.sql.hive.hwc.execution.mode", "spark")
	.config("spark.sql.extensions", "com.qubole.spark.hiveacid.HiveAcidAutoConvertExtension, org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions")
	.config("spark.sql.catalog.spark_catalog.type", "hive")
	.config("spark.sql.catalog.spark_catalog", "org.apache.iceberg.spark.SparkSessionCatalog")
	.config("spark.hadoop.iceberg.engine.hive.enabled", "true")
	.config("spark.jars", "/opt/spark/optional-lib/iceberg-spark-runtime.jar")
	.getOrCreate()
    )

    if is_iceberg_table(spark, dbname, table_name):
	print(f"The table '{dbname}.{table_name}' is an Iceberg table.")
    else:
        print(f"The table '{dbname}.{table_name}' is not an Iceberg table.")



