#!/bin/bash
RESOURCE_SCEHEDULER='https://yunikorn.cde-9x78z7kk.jing-pub.a465-9q4k.cloudera.site/'


WORKLOAD_USER="XXXXXXXX"
export GRAFANA_CHARTS="https://service.cde-ntvvr5hx.go01-dem.ylcu-atmi.cloudera.site/grafana/d/0Oq0WmQWk/instance-metrics?orgId=1&refresh=5s&var-virtual_cluster_name=Spark351"

export CDE_TOKEN=$(curl -u ${WORKLOAD_USER} $(echo ${GRAFANA_CHARTS} | cut -d'/' -f1-3 | awk '{print $1"/gateway/authtkn/knoxtoken/api/v1/token"}') | ./jq -r '.access_token')
#export CDE_TOKEN="CDE_TOKEN=eyJqa3UiOiJodHRwczpcL1wvc2VydmljZS5jZGUtbnR2dnI1aHguZ28wMS1kZW0ueWxjdS1hdG1pLmNsb3VkZXJhLnNpdGVcL2dhdGV3YXlcL2F1dGh0a25cL2tub3h0b2tlblwvYXBpXC92MVwvandrcy5qc29uIiwia2lkIjoibnMzNjBtVnNTU0llanpZaHdSZk1rZTRCSXZ6a1BqbFJFZEVUOURqb2V1SSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJqcHJvc3NlciIsImprdSI6Imh0dHBzOlwvXC9zZXJ2aWNlLmNkZS1udHZ2cjVoeC5nbzAxLWRlbS55bGN1LWF0bWkuY2xvdWRlcmEuc2l0ZVwvZ2F0ZXdheVwvYXV0aHRrblwva25veHRva2VuXC9hcGlcL3YxXC9qd2tzLmpzb24iLCJraWQiOiJuczM2MG1Wc1NTSWVqellod1JmTWtlNEJJdnprUGpsUkVkRVQ5RGpvZXVJIiwiaXNzIjoiS05PWFNTTyIsImV4cCI6MTczMjM4NjAxMSwibWFuYWdlZC50b2tlbiI6ImZhbHNlIiwia25veC5pZCI6ImNhZDdiZDg5LTRhZGYtNDMyYy05MzJkLWVkYjE4OWRjMDI0ZiJ9.jdIQbs41dSAOHp_n344ZQlv7qkFeodOTkGN-XJQ02OENqPHw3bYhpGSYps8JZUleOCfovGpmmlzhJJVBuF2oT02IBa2sobBklL2lB9cfYFk1mf_veUzxXUL-kFHrfXXeu-HMJmjpHwO3ybo9scEykxMq5d88Ty4WwKx9fjcwtql8COx1jXMFAbBp-ZScBuZ6CJk6uRnQ-5LH5JMPDfDXMEwIoV4HUzDr3640f_md0wHAcFm00Cjv6XUvLkCX2ZB5JguELZLJ-QAPhEcKGKILD2atujXFEBvJi5UUfAd1Rd7JK0UIEVaoROEUL1ZSMZoA3PJhYwBT1yevy_zVPX6ERw"
export CDE_JOB_URL="https://4spcd2c8.cde-ntvvr5hx.go01-dem.ylcu-atmi.cloudera.site/dex/api/v1"

# create a resource
#curl -v -H "Authorization: Bearer ${CDE_TOKEN}" -X POST "${CDE_JOB_URL}/resources" -H "Content-Type: application/json"  \
#-H "Accept: */*" -d "{ \"name\": \"jvp-testiceberg\"}"

#curl -H "Authorization: Bearer ${CDE_TOKEN}" -X POST "${CDE_JOB_URL}/jobs" -H "accept: application/json" -H "Content-Type: application/json" \
#-d "{ \"name\": \"jvp-testiceberg-rest\", \"type\": \"spark\", \"retentionPolicy\": \"keep_indefinitely\", \"mounts\": [ { \"dirPrefix\": \"/\",\
# \"resourceName\": \"jvpBMS\" } ], \"spark\": { \"file\": \"isIcebergTable.py\", \"conf\": { \"spark.pyspark.python\": \"python3\" } }, \
# \"schedule\": { \"enabled\": true, \"user\": \"jprosser\", \"cronExpression\": \"30 */1 * * *\", \"start\": \"2024-11-24\", \"end\": \"2024-11-24\" } }"

#leave requestID empty to just generate another job instance
curl -v  -X POST  -H "Authorization: Bearer ${CDE_TOKEN}"  -H "Content-Type: application/json"  -H "Accept: */*"  -d "{ \"requestID\": \"\"}" "${CDE_JOB_URL}/jobs/jvp-testiceberg/run?argv1=ML_Train;argv2=cc_lead_train"


